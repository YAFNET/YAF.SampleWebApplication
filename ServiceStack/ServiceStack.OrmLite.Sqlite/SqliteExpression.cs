﻿// ***********************************************************************
// <copyright file="SqliteExpression.cs" company="ServiceStack, Inc.">
//     Copyright (c) ServiceStack, Inc. All Rights Reserved.
// </copyright>
// <summary>Fork for YetAnotherForum.NET, Licensed under the Apache License, Version 2.0</summary>
// ***********************************************************************

namespace ServiceStack.OrmLite.Sqlite;

using System;
using System.Linq.Expressions;

/// <summary>
/// Class SqliteExpression.
/// Implements the <see cref="ServiceStack.OrmLite.SqlExpression{T}" />
/// </summary>
/// <typeparam name="T"></typeparam>
/// <seealso cref="ServiceStack.OrmLite.SqlExpression{T}" />
public class SqliteExpression<T> : SqlExpression<T>
{
    /// <summary>
    /// Initializes a new instance of the <see cref="SqliteExpression{T}" /> class.
    /// </summary>
    /// <param name="dialectProvider">The dialect provider.</param>
    public SqliteExpression(IOrmLiteDialectProvider dialectProvider)
        : base(dialectProvider)
    {
    }

    /// <summary>
    /// Visits the column access method.
    /// </summary>
    /// <param name="m">The m.</param>
    /// <returns>object.</returns>
    override protected object VisitColumnAccessMethod(MethodCallExpression m)
    {
        var args = this.VisitExpressionList(m.Arguments);
        var quotedColName = this.Visit(m.Object);

        if (!IsSqlClass(quotedColName))
        {
            quotedColName = this.ConvertToParam(quotedColName);
        }

        string statement;

        switch (m.Method.Name)
        {
            case "Substring":
                var startIndex = int.Parse(args[0].ToString()) + 1;
                if (args.Count == 2)
                {
                    var length = int.Parse(args[1].ToString());
                    statement = $"substr({quotedColName}, {startIndex}, {length})";
                }
                else
                {
                    statement = $"substr({quotedColName}, {startIndex})";
                }

                break;
            default:
                return base.VisitColumnAccessMethod(m);
        }

        return new PartialSqlString(statement);
    }

    /// <summary>
    /// Visits the SQL method call.
    /// </summary>
    /// <param name="m">The m.</param>
    /// <returns>object.</returns>
    override protected object VisitSqlMethodCall(MethodCallExpression m)
    {
        var args = this.VisitInSqlExpressionList(m.Arguments);
        object quotedColName = args[0];
        args.RemoveAt(0);

        string statement;

        switch (m.Method.Name)
        {
            case nameof(string.ToString) when m.Object?.Type == typeof(DateTime):
            {
                var arg = args.Count > 0 ? args[0] : null;
                statement = arg == null ? this.ToCast(quotedColName.ToString()) : $"strftime('{arg}',{quotedColName})";

                return new PartialSqlString(statement);
            }
            case nameof(string.Substring):
            {
                var startIndex = int.Parse(args[0].ToString()) + 1;
                if (args.Count == 2)
                {
                    var length = int.Parse(args[1].ToString());
                    statement = $"substr({quotedColName}, {startIndex}, {length})";
                }
                else
                {
                    statement = $"substr({quotedColName}, {startIndex})";
                }

                return new PartialSqlString(statement);
            }
            default:
                return base.VisitSqlMethodCall(m);
        }
    }

    /// <summary>
    /// Converts to lengthpartialstring.
    /// </summary>
    /// <param name="arg">The argument.</param>
    /// <returns>PartialSqlString.</returns>
    override protected PartialSqlString ToLengthPartialString(object arg)
    {
        return new PartialSqlString($"LENGTH({arg})");
    }
}