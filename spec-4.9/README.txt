I am beginning to size out the functional spec for Interchange 4.9/5.0,
and we will need to get the individual bullets listed for inclusion.

So far, we have the following proposed:

spec  Description                                        Proposed by
----  ------------------------------------------------   -----------
yes   Functional spec for overall project                Mike
yes   Sophisticated coupon support                       Mike and Jon
yes   User review for products                           Brev
yes   JavaScript popup menus                             Brev
no    Specification page support for UI                  Mike
no    Localization for Foundation catalog                Mike
yes   Full database configuration capability in UI       Mike
no    Support for XML-RPC requests (non-SOAP)            Mike
no    Improved shipping/taxing UI, country/state-based   Mike
no    Spell checker                                      Ton
yes   System V style ordered configuration               Mike
yes   Update wizard for existing catalog feature add     Mike
no    Ongoing i18n project                               Racke
yes   Email Mailer                                       Alison
yes   Enhanced Usertracking                              Racke	
yes   Static Page Building                               Racke
      (spec yes=Mini-spec in hand)

Keeping in mind that a project is more than its individual
pieces, I will take charge of the following:

	1. Overall goals for the project
	2. Polished marketing specification for the project
	3. Overall functional spec and schedule

I will hold a meeting some time in the next three weeks to flesh
out the specification as a whole, but for now I would like to 
concentrate on preliminary work on the features that are to
be added. 

I decided that we should try using CVS for the specification to
make it easier for us programmer types to understand and use. 8-)
So I added spec-4.9 to the CVS repository with the initial structure:

spec-4.9/README
spec-4.9/coupon/README
spec-4.9/dbconfig/README
spec-4.9/dbconfig/pages/dbconfig.html
spec-4.9/shiptax_ui/README
spec-4.9/specsheet_ui/README
spec-4.9/user_review/README
spec-4.9/xml_rpc/README
spec-4.9/popup_menus/README
spec-4.9/popup_menus/category_vertical_popup
spec-4.9/spelling_checker/README
spec-4.9/sysv_config/README
spec-4.9/update_wizard/README
spec-4.9/email_mailer/README
spec-4.9/usertracking/README
spec-4.9/staticbuild/README

If you want to add your own pet project, all you have to do is
add the directory, create a README file in POD format to tell
people what it is about, and away you go.

You can then add directories, HTML files, ITL snippets, and
even complete working extensions to start prototyping your
concept. When the project really gets started, we segue any working
code from the spec directory into the release, "cvs rm" it to
prevent confusion, and start putting any docs for the 
thing there. When the docs are integrated into the main
docs, we segue that out, and go from there.

At some point, we may just want to put this in the Interchange
directory itself and just not include it in the tarball, but
for now we can keep it separate until we get the procedures
fleshed out.

If you have a pet feature you want to add, the more work you do
on your spec and supporting information, the more likely it
is to get included!

Feedback is appreciated.

