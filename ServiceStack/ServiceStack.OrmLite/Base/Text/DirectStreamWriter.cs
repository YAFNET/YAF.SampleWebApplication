﻿// ***********************************************************************
// <copyright file="DirectStreamWriter.cs" company="ServiceStack, Inc.">
//     Copyright (c) ServiceStack, Inc. All Rights Reserved.
// </copyright>
// <summary>Fork for YetAnotherForum.NET, Licensed under the Apache License, Version 2.0</summary>
// ***********************************************************************

using System.IO;
using System.Text;

namespace ServiceStack.OrmLite.Base.Text;

/// <summary>
/// Class DirectStreamWriter.
/// Implements the <see cref="System.IO.TextWriter" />
/// </summary>
/// <seealso cref="System.IO.TextWriter" />
public class DirectStreamWriter : TextWriter
{
    /// <summary>
    /// The optimized buffer length
    /// </summary>
    private const int optimizedBufferLength = 256;

    /// <summary>
    /// The maximum buffer length
    /// </summary>
    private const int maxBufferLength = 1024;

    /// <summary>
    /// The stream
    /// </summary>
    private readonly Stream stream;

    /// <summary>
    /// The writer
    /// </summary>
    private StreamWriter writer;

    /// <summary>
    /// The current character
    /// </summary>
    private readonly byte[] curChar = new byte[1];

    /// <summary>
    /// The need flush
    /// </summary>
    private bool needFlush;

    /// <summary>
    /// When overridden in a derived class, returns the character encoding in which the output is written.
    /// </summary>
    /// <value>The encoding.</value>
    public override Encoding Encoding { get; }

    /// <summary>
    /// Initializes a new instance of the <see cref="DirectStreamWriter" /> class.
    /// </summary>
    /// <param name="stream">The stream.</param>
    /// <param name="encoding">The encoding.</param>
    public DirectStreamWriter(Stream stream, Encoding encoding)
    {
        this.stream = stream;
        this.Encoding = encoding;
    }

    /// <summary>
    /// Writes the specified s.
    /// </summary>
    /// <param name="s">The s.</param>
    public override void Write(string s)
    {
        if (s.IsNullOrEmpty())
        {
            return;
        }

        if (s.Length <= optimizedBufferLength)
        {
            if (this.needFlush)
            {
                this.writer.Flush();
                this.needFlush = false;
            }

            var buffer = this.Encoding.GetBytes(s);
            this.stream.Write(buffer, 0, buffer.Length);
        }
        else
        {
            this.writer ??= new StreamWriter(this.stream, this.Encoding, s.Length < maxBufferLength ? s.Length : maxBufferLength);

            this.writer.Write(s);
            this.needFlush = true;
        }
    }

    /// <summary>
    /// Writes the specified c.
    /// </summary>
    /// <param name="c">The c.</param>
    public override void Write(char c)
    {
        if (c < 128)
        {
            if (this.needFlush)
            {
                this.writer.Flush();
                this.needFlush = false;
            }

            this.curChar[0] = (byte)c;
            this.stream.Write(this.curChar, 0, 1);
        }
        else
        {
            this.writer ??= new StreamWriter(this.stream, this.Encoding, optimizedBufferLength);

            this.writer.Write(c);
            this.needFlush = true;
        }
    }

    /// <summary>
    /// Flushes this instance.
    /// </summary>
    public override void Flush()
    {
        if (this.writer != null)
        {
            this.writer.Flush();
        }
        else
        {
            this.stream.Flush();
        }
    }
}