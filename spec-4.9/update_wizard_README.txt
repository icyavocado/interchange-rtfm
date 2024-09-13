NAME
       Catalog update wizard

VERSION
       $Revision: 1.1 $ $Id: README,v 1.1 2001/08/03 14:08:50
       heins Exp $

DESCRIPTION OF PROBLEM
       When Interchange is updated now, features are added to the
       UI and the core, but existing catalogs don't pick up some
       of these features due to configuration and database
       structure differences and deficiencies.

       A method of adding new features to existing catalogs is
       needed.

GOALS
       Reliability
           As far as possible, the chance of breaking catalogs by
           adding features should be avoided.

       Clarity
           It should be clear:

                   - what is being added
                   - what is being fixed
                   - what actions are being taken
                   - how to decline the feature update


       Compatibility
           Catalogs using this methodology and older catalogs
           must be able to co-exist. A catalog that is not
           structured such that the update wizard will work
           should be detected and updates should not be offered.

       Easy administration
           It should be easy to tell what updates are available,
           how to apply them, and how to decline them. A wizard
           will be provided to perform this process.

FEATURES
       ·   Updates can be received by means of package-get
           solutions like RPM or apt-get.

       ·   Automatic version updating so that once a package is
           applied, updates are no longer offered.

AUTHOR
       Mike Heins, <mheins@redhat.com>
