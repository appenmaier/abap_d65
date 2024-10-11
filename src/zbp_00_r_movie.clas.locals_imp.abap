CLASS lhc_Movie DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Movie RESULT result.

    METHODS ratemovie FOR MODIFY
      IMPORTING keys FOR ACTION movie~ratemovie RESULT result.

ENDCLASS.


CLASS lhc_Movie IMPLEMENTATION.
  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD RateMovie.
    " Read Movie Data

    " Create Rating
    DATA rating TYPE z00_r_rating.

    READ ENTITY IN LOCAL MODE Z00_R_Movie
         ALL FIELDS
         WITH CORRESPONDING #( keys )
         RESULT FINAL(movies).

    " Validate Rating
    LOOP AT keys INTO FINAL(key).
      IF key-%param-Rating < 1 OR key-%param-Rating > 10.
        " TODO: Fehlerberhandlung
        RETURN.
      ENDIF.

      rating-MovieUuid  = movies[ sy-tabix ]-MovieUuid.
      rating-Rating     = key-%param-Rating.
      rating-RatingDate = sy-datum.
      rating-UserName   = sy-uname.

      MODIFY ENTITY IN LOCAL MODE z00_r_movie
             CREATE BY \_Ratings
             FIELDS ( Rating RatingDate UserName MovieUuid )
             WITH VALUE #( ( %tky    = key-%tky
                             %target = VALUE #( ( %cid       = 'X'
                                                  MovieUuid  = rating-MovieUuid
                                                  Rating     = rating-Rating
                                                  RatingDate = rating-RatingDate
                                                  UserName   = rating-UserName ) ) ) ).
    ENDLOOP.

    result = VALUE #( FOR m IN movies
                      ( %tky = m-%tky %param = m ) ).
  ENDMETHOD.
ENDCLASS.
