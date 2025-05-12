﻿// ***********************************************************************
// <copyright file="TypePair.cs" company="ServiceStack, Inc.">
//     Copyright (c) ServiceStack, Inc. All Rights Reserved.
// </copyright>
// <summary>Fork for YetAnotherForum.NET, Licensed under the Apache License, Version 2.0</summary>
// ***********************************************************************

using System;

namespace ServiceStack.OrmLite.Base.Text.Support;

/// <summary>
/// Class TypePair.
/// </summary>
public class TypePair
{
    /// <summary>
    /// Gets or sets the args1.
    /// </summary>
    /// <value>The args1.</value>
    public Type[] Args1 { get; set; }
    /// <summary>
    /// Gets or sets the arg2.
    /// </summary>
    /// <value>The arg2.</value>
    public Type[] Arg2 { get; set; }

    /// <summary>
    /// Initializes a new instance of the <see cref="TypePair" /> class.
    /// </summary>
    /// <param name="arg1">The arg1.</param>
    /// <param name="arg2">The arg2.</param>
    public TypePair(Type[] arg1, Type[] arg2)
    {
        this.Args1 = arg1;
        this.Arg2 = arg2;
    }

    /// <summary>
    /// Equalses the specified other.
    /// </summary>
    /// <param name="other">The other.</param>
    /// <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    public bool Equals(TypePair other)
    {
        if (ReferenceEquals(null, other))
        {
            return false;
        }

        if (ReferenceEquals(this, other))
        {
            return true;
        }

        return Equals(other.Args1, this.Args1) && Equals(other.Arg2, this.Arg2);
    }

    /// <summary>
    /// Determines whether the specified <see cref="object" /> is equal to this instance.
    /// </summary>
    /// <param name="obj">The object to compare with the current object.</param>
    /// <returns><c>true</c> if the specified <see cref="object" /> is equal to this instance; otherwise, <c>false</c>.</returns>
    public override bool Equals(object obj)
    {
        if (ReferenceEquals(null, obj))
        {
            return false;
        }

        if (ReferenceEquals(this, obj))
        {
            return true;
        }

        return obj.GetType() == typeof(TypePair) && this.Equals((TypePair)obj);
    }

    /// <summary>
    /// Returns a hash code for this instance.
    /// </summary>
    /// <returns>A hash code for this instance, suitable for use in hashing algorithms and data structures like a hash table.</returns>
    public override int GetHashCode()
    {
        unchecked
        {
            return ((this.Args1 != null ? this.Args1.GetHashCode() : 0) * 397) ^ (this.Arg2 != null ? this.Arg2.GetHashCode() : 0);
        }
    }
}