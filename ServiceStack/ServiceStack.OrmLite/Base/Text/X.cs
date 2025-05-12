﻿// ***********************************************************************
// <copyright file="X.cs" company="ServiceStack, Inc.">
//     Copyright (c) ServiceStack, Inc. All Rights Reserved.
// </copyright>
// <summary>Fork for YetAnotherForum.NET, Licensed under the Apache License, Version 2.0</summary>
// ***********************************************************************

#nullable enable

using System;
using System.Runtime.CompilerServices;

namespace ServiceStack.OrmLite.Base.Text;

/// <summary>
/// Avoid polluting extension methods on every type with a 'X.*' short-hand
/// </summary>
public static class X
{
    /// <summary>
    /// Maps the specified from.
    /// </summary>
    /// <typeparam name="From">The type of from.</typeparam>
    /// <typeparam name="To">The type of to.</typeparam>
    /// <param name="from">From.</param>
    /// <param name="fn">The function.</param>
    /// <returns>System.Nullable&lt;To&gt;.</returns>
    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static To? Map<From, To>(From? from, Func<From, To> fn)
    {
        return from == null ? default : fn(from);
    }
}
