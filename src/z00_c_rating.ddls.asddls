@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rating'
@Metadata.allowExtensions: true
define view entity Z00_C_Rating
  as projection on Z00_R_Rating
{
  key RatingUuid,
      MovieUuid,
      UserName,
      Rating,
      RatingDate,

      _Movie : redirected to parent Z00_C_Movie
}
