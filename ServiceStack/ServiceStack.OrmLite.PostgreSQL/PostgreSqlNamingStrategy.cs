﻿// ***********************************************************************
// <copyright file="PostgreSqlNamingStrategy.cs" company="ServiceStack, Inc.">
//     Copyright (c) ServiceStack, Inc. All Rights Reserved.
// </copyright>
// <summary>Fork for YetAnotherForum.NET, Licensed under the Apache License, Version 2.0</summary>
// ***********************************************************************

using ServiceStack.OrmLite.Base.Text;

namespace ServiceStack.OrmLite.PostgreSQL;

/// <summary>
/// Class PostgreSqlNamingStrategy.
/// Implements the <see cref="ServiceStack.OrmLite.OrmLiteNamingStrategyBase" />
/// </summary>
/// <seealso cref="ServiceStack.OrmLite.OrmLiteNamingStrategyBase" />
public class PostgreSqlNamingStrategy : OrmLiteNamingStrategyBase
{
    /// <summary>
    /// Gets the name of the table.
    /// </summary>
    /// <param name="name">The name.</param>
    /// <returns>System.String.</returns>
    public override string GetTableName(string name)
    {
        return name.ToLowercaseUnderscore();
    }

    /// <summary>
    /// Gets the name of the column.
    /// </summary>
    /// <param name="name">The name.</param>
    /// <returns>System.String.</returns>
    public override string GetColumnName(string name)
    {
        return name.ToLowercaseUnderscore();
    }

    /// <summary>
    /// Gets the name of the schema.
    /// </summary>
    /// <param name="name">The name.</param>
    /// <returns>System.String.</returns>
    public override string GetSchemaName(string name)
    {
        return name.ToLowercaseUnderscore();
    }
}