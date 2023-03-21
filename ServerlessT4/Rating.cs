public record Rating(
    string ratingId,
    string userId,
    string productId,
    string locationName,
    int rating,
    string userNotes);