﻿// ***********************************************************************
// <copyright file="TranslateListWithElements.cs" company="ServiceStack, Inc.">
//     Copyright (c) ServiceStack, Inc. All Rights Reserved.
// </copyright>
// <summary>Fork for YetAnotherForum.NET, Licensed under the Apache License, Version 2.0</summary>
// ***********************************************************************

using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading;

using ServiceStack.OrmLite.Base.Text.Common;

namespace ServiceStack.OrmLite.Base.Text;

/// <summary>
/// Class TranslateListWithElements.
/// </summary>
public static class TranslateListWithElements
{
    /// <summary>
    /// The translate i collection cache
    /// </summary>
    private static Dictionary<Type, ConvertInstanceDelegate> TranslateICollectionCache
        = [];

    /// <summary>
    /// Translates to generic i collection cache.
    /// </summary>
    /// <param name="from">From.</param>
    /// <param name="toInstanceOfType">Type of to instance of.</param>
    /// <param name="elementType">Type of the element.</param>
    /// <returns>System.Object.</returns>
    public static object TranslateToGenericICollectionCache(object from, Type toInstanceOfType, Type elementType)
    {
        if (TranslateICollectionCache.TryGetValue(toInstanceOfType, out var translateToFn))
        {
            return translateToFn(from, toInstanceOfType);
        }

        var genericType = typeof(TranslateListWithElements<>).MakeGenericType(elementType);
        var mi = genericType.GetStaticMethod("LateBoundTranslateToGenericICollection");
        translateToFn = (ConvertInstanceDelegate)mi.MakeDelegate(typeof(ConvertInstanceDelegate));

        Dictionary<Type, ConvertInstanceDelegate> snapshot, newCache;
        do
        {
            snapshot = TranslateICollectionCache;
            newCache = new Dictionary<Type, ConvertInstanceDelegate>(TranslateICollectionCache)
                           {
                               [elementType] = translateToFn
                           };

        } while (!ReferenceEquals(
                     Interlocked.CompareExchange(ref TranslateICollectionCache, newCache, snapshot), snapshot));

        return translateToFn(from, toInstanceOfType);
    }

    /// <summary>
    /// The translate convertible i collection cache
    /// </summary>
    private static Dictionary<ConvertibleTypeKey, ConvertInstanceDelegate> TranslateConvertibleICollectionCache
        = [];

    /// <summary>
    /// Translates to convertible generic i collection cache.
    /// </summary>
    /// <param name="from">From.</param>
    /// <param name="toInstanceOfType">Type of to instance of.</param>
    /// <param name="fromElementType">Type of from element.</param>
    /// <returns>System.Object.</returns>
    public static object TranslateToConvertibleGenericICollectionCache(
        object from, Type toInstanceOfType, Type fromElementType)
    {
        var typeKey = new ConvertibleTypeKey(toInstanceOfType, fromElementType);
        if (TranslateConvertibleICollectionCache.TryGetValue(typeKey, out var translateToFn))
        {
            return translateToFn(from, toInstanceOfType);
        }

        var toElementType = toInstanceOfType.FirstGenericType().GetGenericArguments()[0];
        var genericType = typeof(TranslateListWithConvertibleElements<,>).MakeGenericType(fromElementType, toElementType);
        var mi = genericType.GetStaticMethod("LateBoundTranslateToGenericICollection");
        translateToFn = (ConvertInstanceDelegate)mi.MakeDelegate(typeof(ConvertInstanceDelegate));

        Dictionary<ConvertibleTypeKey, ConvertInstanceDelegate> snapshot, newCache;
        do
        {
            snapshot = TranslateConvertibleICollectionCache;
            newCache = new Dictionary<ConvertibleTypeKey, ConvertInstanceDelegate>(TranslateConvertibleICollectionCache)
                           {
                               [typeKey] = translateToFn
                           };

        } while (!ReferenceEquals(
                     Interlocked.CompareExchange(ref TranslateConvertibleICollectionCache, newCache, snapshot), snapshot));

        return translateToFn(from, toInstanceOfType);
    }

    /// <summary>
    /// Tries the translate collections.
    /// </summary>
    /// <param name="fromPropertyType">Type of from property.</param>
    /// <param name="toPropertyType">Type of to property.</param>
    /// <param name="fromValue">From value.</param>
    /// <returns>System.Object.</returns>
    public static object TryTranslateCollections(Type fromPropertyType, Type toPropertyType, object fromValue)
    {
        var args = typeof(IEnumerable<>).GetGenericArgumentsIfBothHaveSameGenericDefinitionTypeAndArguments(
            fromPropertyType, toPropertyType);

        if (args != null)
        {
            return TranslateToGenericICollectionCache(
                fromValue, toPropertyType, args[0]);
        }

        var varArgs = typeof(IEnumerable<>).GetGenericArgumentsIfBothHaveConvertibleGenericDefinitionTypeAndArguments(
            fromPropertyType, toPropertyType);

        if (varArgs != null)
        {
            return TranslateToConvertibleGenericICollectionCache(
                fromValue, toPropertyType, varArgs.Args1[0]);
        }

        var fromElType = fromPropertyType.GetCollectionType();
        var toElType = toPropertyType.GetCollectionType();

        if (fromElType == null || toElType == null)
        {
            return null;
        }

        return TranslateToGenericICollectionCache(fromValue, toPropertyType, toElType);
    }
}

/// <summary>
/// Class ConvertibleTypeKey.
/// </summary>
public class ConvertibleTypeKey
{
    /// <summary>
    /// Converts to instancetype.
    /// </summary>
    /// <value>The type of to instance.</value>
    public Type ToInstanceType { get; set; }
    /// <summary>
    /// Gets or sets the type of from element.
    /// </summary>
    /// <value>The type of from element.</value>
    public Type FromElementType { get; set; }

    /// <summary>
    /// Initializes a new instance of the <see cref="ConvertibleTypeKey" /> class.
    /// </summary>
    /// <param name="toInstanceType">Type of to instance.</param>
    /// <param name="fromElementType">Type of from element.</param>
    public ConvertibleTypeKey(Type toInstanceType, Type fromElementType)
    {
        this.ToInstanceType = toInstanceType;
        this.FromElementType = fromElementType;
    }

    /// <summary>
    /// Equalses the specified other.
    /// </summary>
    /// <param name="other">The other.</param>
    /// <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    public bool Equals(ConvertibleTypeKey other)
    {
        if (other is null)
        {
            return false;
        }

        if (ReferenceEquals(this, other))
        {
            return true;
        }

        return other.ToInstanceType == this.ToInstanceType && other.FromElementType == this.FromElementType;
    }

    /// <summary>
    /// Determines whether the specified <see cref="object" /> is equal to this instance.
    /// </summary>
    /// <param name="obj">The object to compare with the current object.</param>
    /// <returns><c>true</c> if the specified <see cref="object" /> is equal to this instance; otherwise, <c>false</c>.</returns>
    public override bool Equals(object obj)
    {
        if (obj is null)
        {
            return false;
        }

        if (ReferenceEquals(this, obj))
        {
            return true;
        }

        return obj.GetType() == typeof(ConvertibleTypeKey) && this.Equals((ConvertibleTypeKey)obj);
    }

    /// <summary>
    /// Returns a hash code for this instance.
    /// </summary>
    /// <returns>A hash code for this instance, suitable for use in hashing algorithms and data structures like a hash table.</returns>
    public override int GetHashCode()
    {
        unchecked
        {
            return ((this.ToInstanceType != null ? this.ToInstanceType.GetHashCode() : 0) * 397)
                   ^ (this.FromElementType != null ? this.FromElementType.GetHashCode() : 0);
        }
    }
}

/// <summary>
/// Class TranslateListWithElements.
/// </summary>
/// <typeparam name="T"></typeparam>
public class TranslateListWithElements<T>
{
    /// <summary>
    /// Creates the instance.
    /// </summary>
    /// <param name="toInstanceOfType">Type of to instance of.</param>
    /// <returns>System.Object.</returns>
    public static object CreateInstance(Type toInstanceOfType)
    {
        if (!toInstanceOfType.IsGenericType)
        {
            return toInstanceOfType.CreateInstance();
        }

        return toInstanceOfType.HasAnyTypeDefinitionsOf(
                   typeof(ICollection<>), typeof(IList<>)) ? typeof(List<T>).CreateInstance() : toInstanceOfType.CreateInstance();
    }

    /// <summary>
    /// Lates the bound translate to generic i collection.
    /// </summary>
    /// <param name="fromList">From list.</param>
    /// <param name="toInstanceOfType">Type of to instance of.</param>
    /// <returns>System.Object.</returns>
    public static object LateBoundTranslateToGenericICollection(
        object fromList, Type toInstanceOfType)
    {
        if (fromList == null)
        {
            return null;
        }

        if (!toInstanceOfType.IsArray)
        {
            return TranslateToGenericICollection((IEnumerable)fromList, toInstanceOfType);
        }

        var result = TranslateToGenericICollection(
            (IEnumerable)fromList, typeof(List<T>));
        return result.ToArray();

    }

    /// <summary>
    /// Translates to generic i collection.
    /// </summary>
    /// <param name="fromList">From list.</param>
    /// <param name="toInstanceOfType">Type of to instance of.</param>
    /// <returns>ICollection&lt;T&gt;.</returns>
    public static ICollection<T> TranslateToGenericICollection(
        IEnumerable fromList, Type toInstanceOfType)
    {
        var to = (ICollection<T>)CreateInstance(toInstanceOfType);
        foreach (var item in fromList)
        {
            if (item is IEnumerable<KeyValuePair<string, object>> dictionary)
            {
                var convertedItem = dictionary.FromObjectDictionary<T>();
                to.Add(convertedItem);
            }
            else
            {
                to.Add((T)item);
            }
        }
        return to;
    }
}

/// <summary>
/// Class TranslateListWithConvertibleElements.
/// </summary>
/// <typeparam name="TFrom">The type of the t from.</typeparam>
/// <typeparam name="TTo">The type of the t to.</typeparam>
public class TranslateListWithConvertibleElements<TFrom, TTo>
{
    /// <summary>
    /// The convert function
    /// </summary>
    private readonly static Func<TFrom, TTo> ConvertFn;

    /// <summary>
    /// Initializes static members of the <see cref="TranslateListWithConvertibleElements{TFrom, TTo}" /> class.
    /// </summary>
    static TranslateListWithConvertibleElements()
    {
        ConvertFn = GetConvertFn();
    }

    /// <summary>
    /// Lates the bound translate to generic i collection.
    /// </summary>
    /// <param name="fromList">From list.</param>
    /// <param name="toInstanceOfType">Type of to instance of.</param>
    /// <returns>System.Object.</returns>
    public static object LateBoundTranslateToGenericICollection(
        object fromList, Type toInstanceOfType)
    {
        return TranslateToGenericICollection(
            (ICollection<TFrom>)fromList, toInstanceOfType);
    }

    /// <summary>
    /// Translates to generic i collection.
    /// </summary>
    /// <param name="fromList">From list.</param>
    /// <param name="toInstanceOfType">Type of to instance of.</param>
    /// <returns>ICollection&lt;TTo&gt;.</returns>
    public static ICollection<TTo> TranslateToGenericICollection(
        ICollection<TFrom> fromList, Type toInstanceOfType)
    {
        if (fromList == null)
        {
            return null; //AOT
        }

        var to = (ICollection<TTo>)TranslateListWithElements<TTo>.CreateInstance(toInstanceOfType);

        foreach (var item in fromList)
        {
            var toItem = ConvertFn(item);
            to.Add(toItem);
        }
        return to;
    }

    /// <summary>
    /// Gets the convert function.
    /// </summary>
    /// <returns>Func&lt;TFrom, TTo&gt;.</returns>
    private static Func<TFrom, TTo> GetConvertFn()
    {
        if (typeof(TTo) == typeof(string))
        {
            return x => (TTo)(object)TypeSerializer.SerializeToString(x);
        }
        if (typeof(TFrom) == typeof(string))
        {
            return x => TypeSerializer.DeserializeFromString<TTo>((string)(object)x);
        }
        return x => TypeSerializer.DeserializeFromString<TTo>(TypeSerializer.SerializeToString(x));
    }
}