﻿// ***********************************************************************
// <copyright file="JsvReader.Generic.cs" company="ServiceStack, Inc.">
//     Copyright (c) ServiceStack, Inc. All Rights Reserved.
// </copyright>
// <summary>Fork for YetAnotherForum.NET, Licensed under the Apache License, Version 2.0</summary>
// ***********************************************************************

using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Threading;

using ServiceStack.OrmLite.Base.Text.Common;

namespace ServiceStack.OrmLite.Base.Text.Jsv;

/// <summary>
/// Class JsvReader.
/// </summary>
public static class JsvReader
{
    /// <summary>
    /// The instance
    /// </summary>
    readonly static internal JsReader<JsvTypeSerializer> Instance = new();

    /// <summary>
    /// The parse function cache
    /// </summary>
    private static Dictionary<Type, ParseFactoryDelegate> ParseFnCache = [];

    /// <summary>
    /// Gets the parse function.
    /// </summary>
    /// <param name="type">The type.</param>
    /// <returns>ParseStringDelegate.</returns>
    public static ParseStringDelegate GetParseFn(Type type)
    {
        return v => GetParseStringSpanFn(type)(v.AsSpan());
    }

    /// <summary>
    /// Gets the parse span function.
    /// </summary>
    /// <param name="type">The type.</param>
    /// <returns>ParseStringSpanDelegate.</returns>
    public static ParseStringSpanDelegate GetParseSpanFn(Type type)
    {
        return v => GetParseStringSpanFn(type)(v);
    }

    /// <summary>
    /// Gets the parse string span function.
    /// </summary>
    /// <param name="type">The type.</param>
    /// <returns>ParseStringSpanDelegate.</returns>
    public static ParseStringSpanDelegate GetParseStringSpanFn(Type type)
    {
        ParseFnCache.TryGetValue(type, out var parseFactoryFn);

        if (parseFactoryFn != null)
        {
            return parseFactoryFn();
        }

        var genericType = typeof(JsvReader<>).MakeGenericType(type);
        var mi = genericType.GetStaticMethod(nameof(GetParseStringSpanFn));
        parseFactoryFn = (ParseFactoryDelegate)mi.MakeDelegate(typeof(ParseFactoryDelegate));

        Dictionary<Type, ParseFactoryDelegate> snapshot, newCache;
        do
        {
            snapshot = ParseFnCache;
            newCache = new Dictionary<Type, ParseFactoryDelegate>(ParseFnCache)
                           {
                               [type] = parseFactoryFn
                           };

        } while (!ReferenceEquals(
                     Interlocked.CompareExchange(ref ParseFnCache, newCache, snapshot), snapshot));

        return parseFactoryFn();
    }

    /// <summary>
    /// Initializes the aot.
    /// </summary>
    /// <typeparam name="T"></typeparam>
    [MethodImpl(MethodImplOptions.NoInlining | MethodImplOptions.NoOptimization)]
    public static void InitAot<T>()
    {
        Text.Jsv.JsvReader.Instance.GetParseFn<T>();
        Text.Jsv.JsvReader<T>.Parse(default(ReadOnlySpan<char>));
        Text.Jsv.JsvReader<T>.GetParseFn();
        Text.Jsv.JsvReader<T>.GetParseStringSpanFn();
    }
}

/// <summary>
/// Class JsvReader.
/// </summary>
/// <typeparam name="T"></typeparam>
static internal class JsvReader<T>
{
    /// <summary>
    /// The read function
    /// </summary>
    private static ParseStringSpanDelegate ReadFn;

    /// <summary>
    /// Initializes static members of the <see cref="JsvReader{T}" /> class.
    /// </summary>
    static JsvReader()
    {
        Refresh();
    }

    /// <summary>
    /// Refreshes this instance.
    /// </summary>
    public static void Refresh()
    {
        JsConfig.InitStatics();

        if (JsvReader.Instance == null)
        {
            return;
        }

        ReadFn = JsvReader.Instance.GetParseStringSpanFn<T>();
        JsConfig.AddUniqueType(typeof(T));
    }

    /// <summary>
    /// Gets the parse function.
    /// </summary>
    /// <returns>ParseStringDelegate.</returns>
    public static ParseStringDelegate GetParseFn()
    {
        return ReadFn != null
            ? v => ReadFn(v.AsSpan())
            : Parse;
    }

    /// <summary>
    /// Gets the parse string span function.
    /// </summary>
    /// <returns>ParseStringSpanDelegate.</returns>
    public static ParseStringSpanDelegate GetParseStringSpanFn()
    {
        return ReadFn ?? Parse;
    }

    /// <summary>
    /// Parses the specified value.
    /// </summary>
    /// <param name="value">The value.</param>
    /// <returns>System.Object.</returns>
    public static object Parse(string value)
    {
        return value != null
            ? Parse(value.AsSpan())
            : null;
    }

    /// <summary>
    /// Parses the specified value.
    /// </summary>
    /// <param name="value">The value.</param>
    /// <returns>System.Object.</returns>
    /// <exception cref="System.NotSupportedException">Can not deserialize interface type: "
    ///                                                 + typeof(T).Name</exception>
    public static object Parse(ReadOnlySpan<char> value)
    {
        TypeConfig<T>.Init();

        value = value.WithoutBom();

        if (ReadFn == null)
        {
            if (typeof(T).IsInterface)
            {
                throw new NotSupportedException("Can not deserialize interface type: "
                                                + typeof(T).Name);
            }

            Refresh();
        }

        return !value.IsEmpty
                   ? ReadFn(value)
                   : null;
    }
}