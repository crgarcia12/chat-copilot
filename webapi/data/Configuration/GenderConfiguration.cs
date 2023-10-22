﻿using System;
using System.Linq;
using Aydex.SemanticKernel.NL2EF.Data.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Aydex.SemanticKernel.NL2EF.Data.Configuration;

public class GenderConfiguration : IEntityTypeConfiguration<Gender>
{
    public void Configure(EntityTypeBuilder<Gender> builder)
    {
        builder.HasData(Enum.GetValues<Gender.Constant>().Select((gender) => new Gender()
        {
            Id = (int)gender,
            Name = gender.ToString()
        }));
    }
}
