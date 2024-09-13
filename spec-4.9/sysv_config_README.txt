NAME
       Catalog configuration with ordered includes

VERSION
       $Revision: 1.1 $ $Id: README,v 1.1 2001/08/03 13:44:33
       heins Exp $

DESCRIPTION OF PROBLEM
       Currently there is no standard way to add capability to an
       existing Interchange catalog. All catalog configuration
       changes must be placed by means of an edit to catalog.cfg,
       a new include file specified in catalog.cfg, etc.

       Also, in test/live catalog dichotomy, there is no standard
       way to adjust items like database DSN, catalog URL, UI,
       etc.

       A method of adding configuration in an atomic fashion is
       needed.

GOALS
       Atomicity
           Each new configuration piece should be independent of
           another.

       Clarity
           The System V configuration file numbering process is
           well-known by UNIX system administrators, and with a
           small amount of explanation is pretty easily
           understood.

           Actions should be clear during the configuration
           process, by means of an optional diagnostic display,
           which files are being used in configuration.

       Minimal changes to code
           This is a methodology, not really a code feature.
           Interchange with its globbed includes pretty much does
           this now.

       Compatibility
           Catalogs using this methodology and older catalogs
           must be able to co-exist.

       Easy administration
           Configuration can be manipulated by means of symlinks
           or a runlevel editor.

FEATURES
       ·   Configuration file snippets are placed in a common
           directory named for the feature or service they
           implement.

       ·   Symlinks are made to these files with names like
           20database, 40pricebase, 41dealerprice, etc.

AUTHOR
       Mike Heins, <mheins@redhat.com>
