@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Movie'
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity Z00_C_Movie
  provider contract transactional_query
  as projection on Z00_R_Movie
{
  key MovieUuid,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Title,
      @Consumption.valueHelpDefinition: [{ entity: { element: 'Genre', name: 'Z00_I_GenreVH' } }]
      Genre,
      PublishingYear,
      RuntimeInMin,
      ImageUrl,

      CreatedAt,
      CreatedBy,
      LastChangedAt,
      LastChangedBy,

      /* Transient Data */
      _AverageRating.AverageRating,
      AverageRatingCriticality,

      _Ratings : redirected to composition child Z00_C_Rating
}
