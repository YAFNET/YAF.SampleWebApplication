﻿// ***********************************************************************
// <copyright file="RangeAttribute.cs" company="ServiceStack, Inc.">
//     Copyright (c) ServiceStack, Inc. All Rights Reserved.
// </copyright>
// <summary>Fork for YetAnotherForum.NET, Licensed under the Apache License, Version 2.0</summary>
// ***********************************************************************

namespace ServiceStack.DataAnnotations;

using System;

/// <summary>
/// Class RangeAttribute.
/// Implements the <see cref="ServiceStack.AttributeBase" />
/// </summary>
/// <seealso cref="ServiceStack.AttributeBase" />
public class RangeAttribute : AttributeBase
{
    /// <summary>
    /// Gets the minimum.
    /// </summary>
    /// <value>The minimum.</value>
    public object Minimum { get; }

    /// <summary>
    /// Gets the maximum.
    /// </summary>
    /// <value>The maximum.</value>
    public object Maximum { get; }

    /// <summary>
    /// Gets the type of the operand.
    /// </summary>
    /// <value>The type of the operand.</value>
    public Type OperandType { get; }

    /// <summary>
    /// Initializes a new instance of the <see cref="RangeAttribute" /> class.
    /// </summary>
    /// <param name="minimum">The minimum.</param>
    /// <param name="maximum">The maximum.</param>
    public RangeAttribute(int minimum, int maximum)
    {
        this.OperandType = typeof(int);
        this.Minimum = minimum;
        this.Maximum = maximum;
    }

    /// <summary>
    /// Initializes a new instance of the <see cref="RangeAttribute" /> class.
    /// </summary>
    /// <param name="minimum">The minimum.</param>
    /// <param name="maximum">The maximum.</param>
    public RangeAttribute(double minimum, double maximum)
    {
        this.OperandType = typeof(double);
        this.Minimum = minimum;
        this.Maximum = maximum;
    }

    /// <summary>
    /// Initializes a new instance of the <see cref="RangeAttribute" /> class.
    /// </summary>
    /// <param name="type">The type.</param>
    /// <param name="minimum">The minimum.</param>
    /// <param name="maximum">The maximum.</param>
    public RangeAttribute(Type type, string minimum, string maximum)
    {
        this.OperandType = type;
        this.Minimum = minimum;
        this.Maximum = maximum;
    }
}