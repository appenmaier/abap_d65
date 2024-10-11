@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Average Movie Rating'
define view entity Z00_I_AverageMovieRating
  as select from Z00_R_Rating
{
  key MovieUuid,
      @EndUserText.label: 'Average Rating'
      @EndUserText.quickInfo: 'Average Rating'
      avg(Rating as abap.dec(16,1)) as AverageRating
}
group by
  MovieUuid
