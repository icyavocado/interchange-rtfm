# Vend::Payment::Signio - Interchange Signio support
#
# $Id: Signio.pm,v 1.1.2.4 2001/06/29 02:19:26 jon Exp $
#
# Copyright (C) 1999-2001 Red Hat, Inc. <interchange@redhat.com>
#
# Written by Cameron Prince <cprince@redhat.com> and
# Mark Johnson <markj@redhat.com>,
# based on code by Mike Heins <mheins@redhat.com>

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public
# License along with this program; if not, write to the Free
# Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
# MA  02111-1307  USA.

package Vend::Payment::Signio;

=head1 Interchange Signio Support

Vend::Payment::Signio $Revision: 1.1.2.4 $

=head1 SYNOPSIS

    &charge=signio
 
        or
 
    [charge mode=signio param1=value1 param2=value2]

=head1 PREREQUISITES

  Signio PayFlow Pro, Version 2.10 or higher

=head1 DESCRIPTION

The Vend::Payment::Signio module implements the signio() routine
for use with Interchange. It is compatible on a call level with the other
Interchange payment modules -- in theory (and even usually in practice) you
could switch from CyberCash to Signio with a few configuration 
file changes.

To enable this module, place this directive in C<interchange.cfg>:

    Require module Vend::Payment::Signio

This I<must> be in interchange.cfg or a file included from it.

NOTE: Make sure CreditCardAuto is off (default in Interchange demos).

The mode can be named anything, but the C<gateway> parameter must be set
to C<signio>. To make it the default payment gateway for all credit
card transactions in a specific catalog, you can set in C<catalog.cfg>:

    Variable   MV_PAYMENT_MODE  signio

It uses several of the standard settings from Interchange payment. Any time
we speak of a setting, it is obtained either first from the tag/call options,
then from an Interchange order Route named for the mode, then finally a
default global payment variable, For example, the C<id> parameter would
be specified by:

    [charge mode=signio id=YourSignioID]

or

    Route signio id YourSignioID

or with only Signio as a payment provider

    Variable MV_PAYMENT_ID      YoursignioID

The active settings are:

=over 4

=item id

Your account ID, supplied by Signio/VeriSign when you sign up.
Global parameter is MV_PAYMENT_ID.

=item secret

Your account password, selected by you or provided by Signio when you sign up.
Global parameter is MV_PAYMENT_SECRET.

=item partner

Your account partner, selected by you or provided by Verisign when you
sign up. This is required for installations after Feb 15, 2001.
Global parameter is MV_PAYMENT_PARTNER.

=item vendor

Your account vendor, selected by you or provided by Verisign when you
sign up. This is required for installations after Feb 15, 2001.
Global parameter is MV_PAYMENT_PARTNER.

=item transaction

The type of transaction to be run. Valid values are:

    Interchange         Signio
    ----------------    -----------------
	sale                S
	auth                C
	void                V

Default is C<sale>.

=back 

The following should rarely be used, as the supplied defaults are 
usually correct.

=over 4

=item remap 

This remaps the form variable names to the ones needed by Signio. See
the C<Payment Settings> heading in the Interchange documentation for use.

=item host

The Signio host to use. Default is "connect.signio.com>, and C<test.signio.com>
when in test mode. Recent versions use 

=back

=head2 Troubleshooting

Try the instructions above, then enable test mode. A test order should complete.

Then move to live mode and try a sale with the card number C<4111 1111 1111 1111>
and a valid expiration date. The sale should be denied, and the reason should
be in [data session payment_error].

If nothing works:

=over 4

=item *

Make sure you "Require"d the module in interchange.cfg:

    Require module Vend::Payment::Signio

=item *

Make sure the Signio C<pfpro> executable is available either in your
path or in /path_to_interchange/lib.

=item *

Check the error logs, both catalog and global.

=item *

Make sure you set your account ID and secret properly.  

=item *

Try an order, then put this code in a page:

    <XMP>
    [calc]
        my $string = $Tag->uneval( { ref => $Session->{payment_result} });
        $string =~ s/{/{\n/;
        $string =~ s/,/,\n/g;
        return $string;
    [/calc]
    </XMP>

That should show what happened.

=item *

If all else fails, Red Hat and other consultants are available to help
with integration for a fee.

=back

=head1 SECURITY CONSIDERATIONS

Because this library calls an executable, you should ensure that no
untrusted users have write permission on any of the system directories
or Interchange software directories.

=head1 BUGS

There is actually nothing *in* Vend::Payment::Signio. It changes packages
to Vend::Payment and places things there.

=head1 AUTHOR

Mike Heins, <mheins@redhat.com>.

=cut

package Vend::Payment;

sub signio {
#::logDebug("signio called");
	my ($user, $amount) = @_;

	my $opt;
	my $secret;
	if(ref $user) {
		$opt = $user;
		$user = $opt->{id} || undef;
		$secret = $opt->{secret} || undef;
	}
	else {
		$opt = {};
	}

    my $exe;

	my @try = split /:/, $ENV{PATH};
	unshift @try,
			"$Global::VendRoot/lib",
			"$Global::VendRoot/bin",
			"$Global::VendRoot",
			;

	my $stdin;
	for(@try) {
		if(-f "$_/pfpro-file" and -x _) {
			$exe = "$_/pfpro-file";
			$stdin = 1;
			last;
		}
		next unless -f "$_/pfpro" and -x _;
		$exe = "$_/pfpro";
		last;
	}

    if(! $exe ) {
		return (
			MStatus => 'failure-hard',
			MErrMsg => errmsg('pfpro executable not found.'),
			);
    }

	# set loadable module path so not needed in /usr/lib
	@try = split /:/, (charge_param('library_path') || $ENV{LD_LIBRARY_PATH});
	unshift @try,
			"$Global::VendRoot/lib",
			"$Global::VendRoot/bin",
			"$Global::VendRoot",
			;
	$ENV{LD_LIBRARY_PATH} = join ':', @try;

	# set certificat path for modern pfpro
	$ENV{PFPRO_CERT_PATH} ||= charge_param('cert_path');
	if(! -d $ENV{PFPRO_CERT_PATH} ) {
		@try = (
					"$Global::VendRoot",
					"$Global::VendRoot/lib",
					'/usr/local/ssl',
					'/usr/lib/ssl',
				);
		for(@try) {
			next unless  -d "$_/certs";
			$ENV{PFPRO_CERT_PATH} = "$_/certs";
			last;
		}
	}

	my %actual;
	if($opt->{actual}) {
		%actual = %{$opt->{actual}};
	}
	else {
		%actual = map_actual();
	}

    if(! $user  ) {
        $user    =  charge_param('id')
						or return (
							MStatus => 'failure-hard',
							MErrMsg => errmsg('No account id'),
							);
    }
#::logDebug("signio user $user");
    if(! $secret) {
        $secret    =  charge_param('secret')
						or return (
							MStatus => 'failure-hard',
							MErrMsg => errmsg('No account password'),
							);
    }

#::logDebug("signio secret $secret");

	my $server;
	my $port;
	if(! $opt->{host} and charge_param('test')) {
		$server = 'test.signio.com';
		$port   = 443;
	}
	else {
		# We won't read from MV_PAYMENT_SERVER because that would rarely
		# be right and might often be wrong
		$server  =   $opt->{host}  || 'connect.signio.com';
		$port    =   $opt->{port}  || '443';
	}

    $actual{mv_credit_card_exp_month} =~ s/\D//g;
    $actual{mv_credit_card_exp_month} =~ s/^0+//;
    $actual{mv_credit_card_exp_year} =~ s/\D//g;
    $actual{mv_credit_card_exp_year} =~ s/\d\d(\d\d)/$1/;

    $actual{mv_credit_card_number} =~ s/\D//g;

    my $exp = sprintf '%02d%02d',
                        $actual{mv_credit_card_exp_month},
                        $actual{mv_credit_card_exp_year};

    my %type_map = (
        qw/
                        sale          S
                        auth          C
                        authorize     C
                        void          V
                        mauthcapture  S
                        mauthonly     C
                        mauthdelay    D
                        mauthreturn   V
                        S             S
                        C             C
                        D             D
                        V             V
        /
    );

    my $transtype = $opt->{transaction} || charge_param('transaction') || 'S';
	
	$transtype = $type_map{$transtype}
		or return (
				MStatus => 'failure-hard',
				MErrMsg => errmsg('Unrecognized transaction: %s', $transtype),
			);
	

	my $orderID = $opt->{order_id} || gen_order_id($opt);
	$amount = $opt->{total_cost} if ! $amount;

    if(! $amount) {
		my $precision = $opt->{precision} || charge_param('precision') || 2;
        my $cost      = Vend::Interpolate::total_cost();
        $amount = Vend::Util::round_to_frac_digits($cost, $precision);
    }

    my %varmap = ( qw/
                            ACCT     mv_credit_card_number
                            ZIP      b_zip
                            STREET   b_address
        /
    );

    my %query = (
                    AMT         => $amount,
                    SHIPTOZIP   => $actual{zip},
                    EXPDATE     => $exp,
                    TENDER      => 'C',
                    ORIGID      => $orderID,
                    PWD         => $secret,
                    USER        => $user,
					TRXTYPE		=> $transtype,
    );

	$query{PARTNER} = $opt->{partner} || charge_param('partner');
	$query{VENDOR}  = $opt->{vendor}  || charge_param('vendor');

    for (keys %varmap) {
        $query{$_} = $actual{$varmap{$_}};
    }
#::logDebug("signio query: " . ::uneval(\%query));

    my @query;

    for (keys %query) {
        my $key = $_;
        my $val = $query{$key};
        $val =~ s/["\$\n\r]//g;
        $val =~ s/\$//g;
        my $len = length($val);
        if($val =~ /[&=]/) {
            $key .= "[$len]";
        }
        push @query, "$key=$val";
    }
    my $string = join '&', @query;

	my $timeout = $opt->{timeout} || 10;
	$timeout =~ s/\D//g
		and die "Bad timeout value, security violation.";
	$port =~ s/\D//g
		and die "Bad port value, security violation.";
	$server =~ s/[^-\w.]//g
		and die "Bad server value, security violation.";
		
	my $tempfile = "$Vend::Cfg->{ScratchDir}/signio.$orderID";

    my $decline;

	if($stdin) {
#::logDebug(qq{signio STDIN call: $exe $server $port - $timeout > $tempfile});
		open(PFPRO, "| $exe $server $port - $timeout > $tempfile")
			or die "exec pfpro-file: $!\n";
		print PFPRO $string;
		close PFPRO;
	}
	else {
#::logDebug(qq{signio call: $exe $server $port "$string" $timeout > $tempfile});
		system(qq{$exe $server $port "$string" $timeout > $tempfile});
	}

	$decline = $?;

    open(CONNECT, "< $tempfile")
		or die ::errmsg("open %s: %s\n", $tempfile, $!);
    
    my $result = join "", <CONNECT>;
    close CONNECT;

#::logDebug(qq{signio decline=$decline result: $result});

    my %result_map = ( qw/

            MStatus               ICSTATUS
            pop.status            ICSTATUS
            order-id              PNREF
            pop.order-id          PNREF
            pop.auth-code         AUTHCODE
            pop.avs_code          AVSZIP
            pop.avs_zip           AVSZIP
            pop.avs_addr          AVSADDR
    /
    );

    my %result = split /[&=]/, $result;

    if ($decline) {
        $decline = $decline >> 8;
        $result{ICSTATUS} = 'failed';

		my $msg = errmsg("Charge error: %s Reason: %s. Please call in your order or try again.",
			$result{RESULT} ,
			$result{RESPMSG},
		);
		$result{MErrMsg} = $result{'pop.error-message'} = $msg;
    }
    else {
        $result{ICSTATUS} = 'success';
    }

    for (keys %result_map) {
        $result{$_} = $result{$result_map{$_}}
            if defined $result{$result_map{$_}};
    }

#::logDebug(qq{signio decline=$decline result: } . ::uneval( \%result));

    return %result;
}

*verisign = \&signio;

package Vend::Payment::Signio;

1;
