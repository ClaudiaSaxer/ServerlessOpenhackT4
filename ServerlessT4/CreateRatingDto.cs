using System;

namespace Z.CreateRating
{
    internal class CreateRatingDto
    {
        public Guid UserId { get; set; }
        public Guid ProductId { get; set; }
        public string LocationName { get; set; }
        public int Rating { get; set; }
        public string UserNotes { get; set; }
    }
}