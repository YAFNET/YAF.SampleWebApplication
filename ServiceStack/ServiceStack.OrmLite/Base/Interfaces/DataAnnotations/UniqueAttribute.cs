﻿// ***********************************************************************
// <copyright file="UniqueAttribute.cs" company="ServiceStack, Inc.">
//     Copyright (c) ServiceStack, Inc. All Rights Reserved.
// </copyright>
// <summary>Fork for YetAnotherForum.NET, Licensed under the Apache License, Version 2.0</summary>
// ***********************************************************************
using System;

namespace ServiceStack.DataAnnotations;

/// <summary>
/// Class UniqueAttribute.
/// Implements the <see cref="ServiceStack.AttributeBase" />
/// </summary>
/// <seealso cref="ServiceStack.AttributeBase" />
[AttributeUsage(AttributeTargets.Property)]
public class UniqueAttribute : AttributeBase;