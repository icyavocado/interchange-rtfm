NAME
       Interchange Coupons and Discounts

VERSION
       $Revision: 1.1.1.1 $ $Id: README,v 1.1.1.1 2001/07/25
       18:33:34 heins Exp $

NEED
       Store owners need to be able to run promotions on their
       web site, keyed to advertising campaigns. While
       Interchange is flexible enough to allow this type of
       thing, a standardized facility can provide a repeatable
       method to achieve the following ends:

       ·   Reliable discounting based on source of lead,
           affiliate, and campaign.

       ·   Defined run time for the promotion, i.e. a start date
           and end date.

       ·   Defined number of redeemable coupons, i.e. "first one
           hundred to purchase foo get a free bar".

       ·   Statistics on number of coupons issued, number
           redeemed, source of click (affiliate), and type of ad
           (campaign).

       ·   Generation of banner ad code to initiate coupon.

       ·   Page code to show the purchaser the discount and
           credit it to their purchase.

CURRENT MEANS
       Interchange has a discount facility which allows a Perl
       function to return the total price you should pay for an
       item line -- i.e. the pseudocode:

           final_price = discount(sku, price, quantity)

       A user can format page code such that a discount is issued
       only when appropriate:

           [if session source eq promotion_x]
               [discount foo]
                   return $s * .80;
               [/discount]
               You will receive a 20% discount when you purchase any number
               of our fine [page foo]Foo dogs[/page]!
           [/if]

       However, there is no standard facility to initiate the
       NEEDS shown above.  You can easily do them with
       Interchange; for example, an expiration can be done with:

           [comment]
               Could set with Variable in config file or DB
           [/comment]
           [set promo]foo[/set]

           [perl tables=merchandising]
               # initialize
               delete $Scratch->{do_discount};
               # No discount if not from right source
               return unless $Session->{source} eq 'promotion_x';

               my $item    = $Scratch->{promo};
               my $current = $Tag->time('%Y%m%d');

               my $begin   = $Tag->data('merchandising', 'start_date', $Scratch->{promo});
               return if $current lt $begin;

               my $end   = $Tag->data('merchandising', 'end_date', $Scratch->{promo});
               return unless $end ge $current;

               $Scratch->{do_discount} = 1;
               return;
           [/perl]

           [if scratch do_discount]
               [discount foo]
                   return $s * .80;
               [/discount]
               You will receive a 20% discount when you purchase any number
               of our fine [page foo]Foo dogs[/page]!
           [/if]

       This is just a bit too technical for the average store
       owner, and each owner must define their own methodology.

PROPOSED
       A standard coupon methodology defined with a new *coupon*
       database. We examined using the merchandising database,
       but it would be difficult to run more than one
       simultaneous promotion on the same SKU using that as the
       source.

       The facility will have the following characteristics:

           1. At definition time, coupons can be limited by several of the
              following criteria:'

               a. Source
               b. Ad campaign
               c. Number to issue
               d. Number redeemed
               e. Expiration date
               f. Start date

           2. Coupons can be activated or deactivated with a single button.

           3. User interface support will be provided to generate discounts
              automatically based on:

               a. Percent/amount off order
               b. Percent/amount off certain item
               c. Percent/amount off item groups
               d. Buy one, get one free (or half-off)
               e. Buy foo, get bar free (or half-off)

           These will generate discount code compatible with
           Interchange's current facility. In the case of more complex
           needs, the user will be able to go directly to embedded Perl
           to generate the discount.

           4. Reports page will show number of coupons issued, number
              redeemed, and conversion rate. Each will be taggable based on
              affiliate or campaign.


       DATA DESCRIPTION

       The coupon table will be a many-to-one table based on SKU
       and/or ALL_ITEMS and ENTIRE_ORDER (the standard
       Interchange discount types).

       Table fields:

           code:         integer uniquely identifying promotion
           amount:       The discount code (or pseudo-code)
           sku:          The SKU of the item, or ALL_ITEMS or ENTIRE_ORDER
           affiliate:    Affiliate for which active (if any)
           text:         Text of the coupon offer
           image:        Image to present (if any)
           limit_by:     Type of limit (issued, redeemed)
           limit:        Number of the limit
           number_given: Writable field to store number issued
           number_used:  Writable field to store number redeemed
           start_date:   Start date of promotion (default none)
           expiration:   End date of promotion (default none)
           secret:       Secret used to generate checksum

       All are character data types; constraints done by
       Interchange.

RESOURCES
               Mike Heins, 2 weeks (UI coding)
               Jon Jensen, 2 weeks (engine coding)
               Brev Patterson, 1 week (Foundation integration)


AUTHORS
       Mike Heins, <mheins@redhat.com>
       Jon Jensen, <jon@redhat.com>
