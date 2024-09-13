NAME
       User review component for Foundation

VERSION
       $Revision: 1.2 $ $Id: README,v 1.2 2001/08/06 15:23:31
       brevp Exp $

DESCRIPTION
       On online shopping sites such as Amazon.com there are
       "User Ratings and Reviews" below the product information
       on each detailed product flypage.  Most commonly store
       users will post comments about the product, and then will
       give it a rating (4 out of 5 stars, etc.)  The overall
       average rating is usually displayed as well.

       This will be a component, kept in the
       templates/components/ directory, tentatively named
       "reviews".  This component will most commonly be placed on
       the flypage, as the after-content component, below the
       product information table.  The component will have the
       following changeable options:      amount         the
       number of reviews to display      multiple  boolean, allow
       a customer to post multiple reviews?
            ratemax        max rating value - 5 stars?  a 10?

       All store users will see an "Overall Rating" (the
       mathematical average of all the individual user ratings),
       followed by a list of individual user reviews/ratings.
       The most recent ratings will be shown from newest to
       oldest.

       Users who have created an account, and are logged in, will
       see an additional link to "Post a Review".

       A "review" table will be created in the database.  Lexicon
       of table columns:      sku            primary key.  sku of
       the item this review is related to.       date      date
       of the review, for sorting the display order
            customer  customer ID of the person who posted the
       review      email          boolean, make the customers
       email address visible?       rating         the rating of
       the product      comment        a comment on the product
             Possible future expansion on this component:      A
       "see all reviews" link.       Rate the ratings, i.e. "Was
       this review helpful to you?", and display           by
       most helpful reviews.       Allow the store admins to
       select "Official Store Reviewers", and give           any
       of these reviews precedence over regular customer reviews.

AUTHOR
       Brev Patterson, <bpatters@redhat.com>
