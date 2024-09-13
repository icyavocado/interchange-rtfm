NAME
       Javascript popup menus for Foundation

VERSION
       $Revision: 1.2 $ $Id: README,v 1.2 2001/08/13 15:59:54
       brevp Exp $

DESCRIPTION
       This is a proposal for Javascript Popup Menus for the
       Category Listing.

       There are two ways to go about this:

       1. Cross-platform, cross-browser friendly popup menus -
       this will be
          the best visually, but the hardest to implement - it
       will require
          changes across many files in different locations.

       2. Not so platform/browser friendly, but all contained in
       a single
          component (i.e. category_vertical_popup).  All the
       current components
          are layered deep in tables from the html files, and the
       header files.
          Many cross-browser/platform dynamic html bugs happen
       because of layers
          being deep inside these tables.  This method will not
       work in NS4, because
          of known browser bugs.

       I have code for method #2 already written (see
       category_vertical_popup) in this directory.  It works good
       in IE:Win and NS6:win.  But NS4:win is completely broken
       (a known browser bug), and on the Mac:IE it is in the
       wrong place.  A browser detection will need to be done,
       and the javascript menus placed accordingly.

       There is user-contributed code out there for method #1
       (some by Brian Kohles that I know of for sure - see
       www.briankohles.com/interchange), and if we feel that is
       the better route to go, it should be easy to implement -
       but in my view, messy and hard to keep track of.

AUTHOR
       Brev Patterson, <bpatters@redhat.com>
