﻿/*
 * Diff Match and Patch
 * Copyright 2018 The diff-match-patch Authors.
 * https://github.com/google/diff-match-patch
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

namespace YAF.Core.Utilities.StringUtils;

using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;

/// <summary>
/// The compatibility extensions.
/// </summary>
static internal class CompatibilityExtensions
{
    /// <summary>
    /// JScript splice function
    /// </summary>
    /// <param name="input">
    /// The input.
    /// </param>
    /// <param name="start">
    /// The start.
    /// </param>
    /// <param name="count">
    /// The count.
    /// </param>
    /// <param name="objects">
    /// The objects.
    /// </param>
    /// <typeparam name="T">
    /// </typeparam>
    /// <returns>
    /// Returns spliced list
    /// </returns>
    public static List<T> Splice<T>(this List<T> input, int start, int count, params T[] objects)
    {
        var deletedRange = input.GetRange(start, count);
        input.RemoveRange(start, count);
        input.InsertRange(start, objects);

        return deletedRange;
    }

    /// <summary>
    /// Java substring function
    /// </summary>
    /// <param name="s">
    /// The s.
    /// </param>
    /// <param name="begin">
    /// The begin.
    /// </param>
    /// <param name="end">
    /// The end.
    /// </param>
    /// <returns>
    /// The <see cref="string"/>.
    /// </returns>
    public static string JavaSubstring(this string s, int begin, int end)
    {
        return s[begin..end];
    }
}

/**-
     * The data structure representing a diff is a List of Diff objects:
     * {Diff(Operation.DELETE, "Hello"), Diff(Operation.INSERT, "Goodbye"),
     *  Diff(Operation.EQUAL, " world.")}
     * which means: delete "Hello", add "Goodbye" and keep " world."
     */
/// <summary>
/// Enum Operation
/// </summary>
public enum Operation
{
    /// <summary>
    /// The delete
    /// </summary>
    Delete,

    /// <summary>
    /// The insert
    /// </summary>
    Insert,

    /// <summary>
    /// The equal
    /// </summary>
    Equal
}

/// <summary>
/// Class representing one diff operation.
/// </summary>
public class Diff
{
    /// <summary>
    /// The operation
    /// </summary>
    public Operation Operation { get; set; }

    /// <summary>
    /// The text associated with this diff operation.
    /// </summary>
    public string Text { get; set; }

    /// <summary>
    /// Initializes a new instance of the <see cref="Diff"/> class.
    /// </summary>
    /// <param name="operation">The operation.</param>
    /// <param name="text">The text.</param>
    public Diff(Operation operation, string text)
    {
        // Construct a diff with the specified operation and text.
        this.Operation = operation;
        this.Text = text;
    }
}

/// <summary>
/// Class containing the diff, match and patch methods.
/// Also Contains the behaviour settings.
/// </summary>
public class DiffMatchPatch
{
    /// <summary>
    /// Number of seconds to map a diff before giving up (0 for infinity).
    /// </summary>
    public float DiffTimeout { get; set; } = 1.0f;

    /// <summary>
    /// Chunk size for context length.
    /// </summary>
    public short PatchMargin { get; set; } = 4;

    /// <summary>
    /// Find the differences between two texts.
    /// </summary>
    /// <param name="text1">Old string to be diffed.</param>
    /// <param name="text2">New string to be diffed.</param>
    /// <param name="checkLines">Check lines Speedup flag.  If false, then don't run a
    /// line-level diff first to identify the changed areas.
    /// If true, then run a faster slightly less optimal diff.</param>
    /// <returns>List of Diff objects.</returns>
    public List<Diff> DiffMain(string text1, string text2, bool checkLines)
    {
        // Set a deadline by which time the diff must be complete.
        DateTime deadline;
        if (this.DiffTimeout <= 0)
        {
            deadline = DateTime.MaxValue;
        }
        else
        {
            deadline = DateTime.Now + new TimeSpan((long) (this.DiffTimeout * 1000) * 10000);
        }

        return this.DiffMain(text1, text2, checkLines, deadline);
    }

    /// <summary>
    /// Find the differences between two texts.  Simplifies the problem by
    /// stripping any common prefix or suffix off the texts before diffing.
    /// </summary>
    /// <param name="text1">Old string to be diffed.</param>
    /// <param name="text2">New string to be diffed.</param>
    /// <param name="checkLines">Time when the diff should be complete by.
    /// Used internally for recursive calls.Users should set DiffTimeout instead.</param>
    /// <param name="deadline">Time when the diff should be complete by.
    /// Used internally for recursive calls.Users should set DiffTimeout
    /// instead.
    /// </param>
    /// <returns>List of Diff objects.</returns>
    private List<Diff> DiffMain(string text1, string text2, bool checkLines, DateTime deadline)
    {
        // Check for null inputs not needed since null can't be passed in C#.

        // Check for equality (speedup).
        List<Diff> diffs;
        if (text1 == text2)
        {
            diffs = [];
            if (text1.Length != 0)
            {
                diffs.Add(new Diff(Operation.Equal, text1));
            }

            return diffs;
        }

        // Trim off common prefix (speedup).
        var commonLength = CommonPrefix(text1, text2);
        var commonPrefix = text1[..commonLength];
        text1 = text1[commonLength..];
        text2 = text2[commonLength..];

        // Trim off common suffix (speedup).
        commonLength = CommonSuffix(text1, text2);
        var commonSuffix = text1[^commonLength..];
        text1 = text1[..^commonLength];
        text2 = text2[..^commonLength];

        // Compute the diff on the middle block.
        diffs = this.Compute(text1, text2, checkLines, deadline);

        // Restore the prefix and suffix.
        if (commonPrefix.Length != 0)
        {
            diffs.Insert(0, new Diff(Operation.Equal, commonPrefix));
        }

        if (commonSuffix.Length != 0)
        {
            diffs.Add(new Diff(Operation.Equal, commonSuffix));
        }

        CleanupMerge(diffs);
        return diffs;
    }

    /// <summary>
    /// Find the differences between two texts.  Assumes that the texts do not
    /// have any common prefix or suffix.
    /// </summary>
    /// <param name="text1">Old string to be diffed.</param>
    /// <param name="text2">New string to be diffed.</param>
    /// <param name="checkLines">Speedup flag.  If false, then don't run a
    /// line-level diff first to identify the changed areas.
    /// If true then run a faster slightly less optimal diff.</param>
    /// <param name="deadline">Time when the diff should be complete by.</param>
    /// <returns>List of Diff objects.</returns>
    private List<Diff> Compute(string text1, string text2, bool checkLines, DateTime deadline)
    {
        var diffs = new List<Diff>();

        if (text1.Length == 0)
        {
            // Just add some text (speedup).
            diffs.Add(new Diff(Operation.Insert, text2));
            return diffs;
        }

        if (text2.Length == 0)
        {
            // Just delete some text (speedup).
            diffs.Add(new Diff(Operation.Delete, text1));
            return diffs;
        }

        var longtext = text1.Length > text2.Length ? text1 : text2;
        var shortText = text1.Length > text2.Length ? text2 : text1;
        var i = longtext.IndexOf(shortText, StringComparison.Ordinal);
        if (i != -1)
        {
            // Shorter text is inside the longer text (speedup).
            var op = text1.Length > text2.Length ? Operation.Delete : Operation.Insert;
            diffs.Add(new Diff(op, longtext[..i]));
            diffs.Add(new Diff(Operation.Equal, shortText));
            diffs.Add(new Diff(op, longtext[(i + shortText.Length)..]));
            return diffs;
        }

        if (shortText.Length == 1)
        {
            // Single character string.
            // After the previous speedup, the character can't be an equality.
            diffs.Add(new Diff(Operation.Delete, text1));
            diffs.Add(new Diff(Operation.Insert, text2));
            return diffs;
        }

        // Check to see if the problem can be split in two.
        var hm = this.HalfMatch(text1, text2);
        if (hm != null)
        {
            // A half-match was found, sort out the return data.
            var text1A = hm[0];
            var text1B = hm[1];
            var text2A = hm[2];
            var text2B = hm[3];
            var midCommon = hm[4];
            // Send both pairs off for separate processing.
            var diffsA = this.DiffMain(text1A, text2A, checkLines, deadline);
            var diffsB = this.DiffMain(text1B, text2B, checkLines, deadline);
            // Merge the results.
            diffs = diffsA;
            diffs.Add(new Diff(Operation.Equal, midCommon));
            diffs.AddRange(diffsB);
            return diffs;
        }

        if (checkLines && text1.Length > 100 && text2.Length > 100)
        {
            return this.LineMode(text1, text2, deadline);
        }

        return this.Bisect(text1, text2, deadline);
    }

    /// <summary>
    /// Do a quick line-level diff on both strings, then re-diff the parts for
    /// greater accuracy.
    /// This speedup can produce non-minimal diffs.
    /// </summary>
    /// <param name="text1">Old string to be diffed.</param>
    /// <param name="text2">New string to be diffed.</param>
    /// <param name="deadline">Time when the diff should be complete by.</param>
    /// <returns>List of Diff objects.</returns>
    private List<Diff> LineMode(string text1, string text2, DateTime deadline)
    {
        // Scan the text on a line-by-line basis first.
        var a = LinesToChars(text1, text2);
        text1 = (string) a[0];
        text2 = (string) a[1];
        var lineArray = (List<string>) a[2];

        var diffs = this.DiffMain(text1, text2, false, deadline);

        // Convert the diff back to original text.
        CharsToLines(diffs, lineArray);
        // Eliminate freak matches (e.g. blank lines)
        this.CleanupSemantic(diffs);

        // Re-diff any replacement blocks, this time character-by-character.
        // Add a dummy entry at the end.
        diffs.Add(new Diff(Operation.Equal, string.Empty));
        var pointer = 0;
        var countDelete = 0;
        var countInsert = 0;
        var textDelete = string.Empty;
        var textInsert = new StringBuilder();
        while (pointer < diffs.Count)
        {
            switch (diffs[pointer].Operation)
            {
                case Operation.Insert:
                    countInsert++;
                    textInsert.Append(diffs[pointer].Text);
                    break;
                case Operation.Delete:
                    countDelete++;
                    textDelete += diffs[pointer].Text;
                    break;
                case Operation.Equal:
                    // Upon reaching an equality, check for prior redundancies.
#pragma warning disable S2583 // Conditionally executed code should be reachable
                    if (countDelete >= 1 && countInsert >= 1)
                    {
                        // Delete the offending records and add the merged ones.
                        diffs.RemoveRange(pointer - countDelete - countInsert, countDelete + countInsert);
                        pointer = pointer - countDelete - countInsert;
                        var subDiff = this.DiffMain(textDelete, textInsert.ToString(), false, deadline);
                        diffs.InsertRange(pointer, subDiff);
                        pointer += subDiff.Count;
                    }
#pragma warning restore S2583 // Conditionally executed code should be reachable

                    countInsert = 0;
                    countDelete = 0;
                    textDelete = string.Empty;
                    textInsert = textInsert.Clear();
                    break;
            }

            pointer++;
        }

        diffs.RemoveAt(diffs.Count - 1); // Remove the dummy entry at the end.

        return diffs;
    }

    /// <summary>
    /// Find the 'middle snake' of a diff, split the problem in two
    /// and return the recursively constructed diff.
    /// See Myers 1986 paper: An O(ND) Difference Algorithm and Its Variations.
    /// </summary>
    /// <param name="text1">Old string to be diffed.</param>
    /// <param name="text2">New string to be diffed.</param>
    /// <param name="deadline">Time at which to bail if not yet complete.</param>
    /// <returns>List of Diff objects.</returns>
    protected List<Diff> Bisect(string text1, string text2, DateTime deadline)
    {
        // Cache the text lengths to prevent multiple calls.
        var text1Length = text1.Length;
        var text2Length = text2.Length;
        var maxD = (text1Length + text2Length + 1) / 2;
        var length = 2 * maxD;
        var v1 = new int[length];
        var v2 = new int[length];
        for (var x = 0; x < length; x++)
        {
            v1[x] = -1;
            v2[x] = -1;
        }

        v1[maxD + 1] = 0;
        v2[maxD + 1] = 0;
        var delta = text1Length - text2Length;
        // If the total number of characters is odd, then the front path will
        // collide with the reverse path.
        var front = delta % 2 != 0;
        // Offsets for start and end of k loop.
        // Prevents mapping of space beyond the grid.
        var k1Start = 0;
        var k1End = 0;
        var k2Start = 0;
        var k2End = 0;
        for (var d = 0; d < maxD; d++)
        {
            // Bail out if deadline is reached.
            if (DateTime.Now > deadline)
            {
                break;
            }

            // Walk the front path one step.
            for (var k1 = -d + k1Start; k1 <= d - k1End; k1 += 2)
            {
                var k1Offset = maxD + k1;
                int x1;
                if (k1 == -d || k1 != d && v1[k1Offset - 1] < v1[k1Offset + 1])
                {
                    x1 = v1[k1Offset + 1];
                }
                else
                {
                    x1 = v1[k1Offset - 1] + 1;
                }

                var y1 = x1 - k1;
                while (x1 < text1Length && y1 < text2Length && text1[x1] == text2[y1])
                {
                    x1++;
                    y1++;
                }

                v1[k1Offset] = x1;
                if (x1 > text1Length)
                {
                    // Ran off the right of the graph.
                    k1End += 2;
                }
                else if (y1 > text2Length)
                {
                    // Ran off the bottom of the graph.
                    k1Start += 2;
                }
                else if (front)
                {
                    var k2Offset = maxD + delta - k1;
                    if (k2Offset < 0 || k2Offset >= length || v2[k2Offset] == -1)
                    {
                        continue;
                    }

                    // Mirror x2 onto top-left coordinate system.
                    var x2 = text1Length - v2[k2Offset];
                    if (x1 >= x2)
                    {
                        // Overlap detected.
                        return this.BisectSplit(text1, text2, x1, y1, deadline);
                    }
                }
            }

            // Walk the reverse path one step.
            for (var k2 = -d + k2Start; k2 <= d - k2End; k2 += 2)
            {
                var k2Offset = maxD + k2;
                int x2;
                if (k2 == -d || k2 != d && v2[k2Offset - 1] < v2[k2Offset + 1])
                {
                    x2 = v2[k2Offset + 1];
                }
                else
                {
                    x2 = v2[k2Offset - 1] + 1;
                }

                var y2 = x2 - k2;
                while (x2 < text1Length && y2 < text2Length
                                        && text1[text1Length - x2 - 1] == text2[text2Length - y2 - 1])
                {
                    x2++;
                    y2++;
                }

                v2[k2Offset] = x2;
                if (x2 > text1Length)
                {
                    // Ran off the left of the graph.
                    k2End += 2;
                }
                else if (y2 > text2Length)
                {
                    // Ran off the top of the graph.
                    k2Start += 2;
                }
                else if (!front)
                {
                    var k1Offset = maxD + delta - k2;
                    if (k1Offset < 0 || k1Offset >= length || v1[k1Offset] == -1)
                    {
                        continue;
                    }

                    var x1 = v1[k1Offset];
                    var y1 = maxD + x1 - k1Offset;
                    // Mirror x2 onto top-left coordinate system.
                    x2 = text1Length - v2[k2Offset];
                    if (x1 >= x2)
                    {
                        // Overlap detected.
                        return this.BisectSplit(text1, text2, x1, y1, deadline);
                    }
                }
            }
        }

        // Diff took too long and hit the deadline or
        // number of diffs equals number of characters, no commonality at all.
        var diffs = new List<Diff> {new(Operation.Delete, text1), new(Operation.Insert, text2)};
        return diffs;
    }

    /// <summary>
    /// Given the location of the 'middle snake', split the diff in two parts
    /// and recurse.
    /// </summary>
    /// <param name="text1">Old string to be diffed.</param>
    /// <param name="text2">New string to be diffed.</param>
    /// <param name="x">Index of split point in text1.</param>
    /// <param name="y">Index of split point in text2.</param>
    /// <param name="deadline">Time at which to bail if not yet complete.</param>
    /// <returns>LinkedList of Diff objects.</returns>
    private List<Diff> BisectSplit(string text1, string text2, int x, int y, DateTime deadline)
    {
        var text1A = text1[..x];
        var text2A = text2[..y];
        var text1B = text1[x..];
        var substring = text2[y..];

        // Compute both diffs serially.
        var diffs = this.DiffMain(text1A, text2A, false, deadline);
        var diffsB = this.DiffMain(text1B, substring, false, deadline);

        diffs.AddRange(diffsB);
        return diffs;
    }

    /// <summary>
    /// Split two texts into a list of strings.  Reduce the texts to a string of
    /// * hashes where each Unicode character represents one line.
    /// </summary>
    /// <param name="text1">First string.</param>
    /// <param name="text2">Second string.</param>
    /// <returns>Three element Object array, containing the encoded text1, the
    /// encoded text2 and the List of unique strings.  The zeroth element
    /// of the List of unique strings is intentionally blank.</returns>
    static protected object[] LinesToChars(string text1, string text2)
    {
        var lineArray = new List<string>();
        var lineHash = new Dictionary<string, int>();

        // "\x00" is a valid character, but various debuggers don't like it.
        // So we'll insert a junk entry to avoid generating a null character.
        lineArray.Add(string.Empty);

        // Allocate 2/3rds of the space for text1, the rest for text2.
        var chars1 = LinesToCharsMunge(text1, lineArray, lineHash, 40000);
        var chars2 = LinesToCharsMunge(text2, lineArray, lineHash, 65535);
        return [chars1, chars2, lineArray];
    }

    /// <summary>
    /// Split a text into a list of strings.  Reduce the texts to a string of
    /// hashes where each Unicode character represents one line.
    /// </summary>
    /// <param name="text">String to encode.</param>
    /// <param name="lineArray">Array List of unique strings.</param>
    /// <param name="lineHash">Hash Map of strings to indices.</param>
    /// <param name="maxLines">Maximum length of lineArray.</param>
    /// <returns>Encoded string.</returns>
    private static string LinesToCharsMunge(
        string text,
        List<string> lineArray,
        Dictionary<string, int> lineHash,
        int maxLines)
    {
        var lineStart = 0;
        var lineEnd = -1;
        var chars = new StringBuilder();
        // Walk the text, pulling out a Substring for each line.
        // text.split('\n') would would temporarily double our memory footprint.
        // Modifying text would create many large strings to garbage collect.
        while (lineEnd < text.Length - 1)
        {
            lineEnd = text.IndexOf('\n', lineStart);
            if (lineEnd == -1)
            {
                lineEnd = text.Length - 1;
            }

            var line = text.JavaSubstring(lineStart, lineEnd + 1);

            if (lineHash.TryGetValue(line, out var value))
            {
                chars.Append((char) value);
            }
            else
            {
                if (lineArray.Count == maxLines)
                {
                    // Bail out at 65535 because char 65536 == char 0.
                    line = text[lineStart..];
                    lineEnd = text.Length;
                }

                lineArray.Add(line);
                lineHash.Add(line, lineArray.Count - 1);
                chars.Append((char) (lineArray.Count - 1));
            }

            lineStart = lineEnd + 1;
        }

        return chars.ToString();
    }

    /// <summary>
    /// Rehydrate the text in a diff from a string of line hashes to real lines
    /// of text.
    /// </summary>
    /// <param name="diffs">diffs List of Diff objects.</param>
    /// <param name="lineArray">Array List of unique strings.</param>
    static protected void CharsToLines(ICollection<Diff> diffs, IList<string> lineArray)
    {
        foreach (var diff in diffs)
        {
            var text = new StringBuilder();
            foreach (var t in diff.Text)
            {
                text.Append(lineArray[t]);
            }

            diff.Text = text.ToString();
        }
    }

    /// <summary>
    /// Determine the common prefix of two strings.
    /// </summary>
    /// <param name="text1">First string.</param>
    /// <param name="text2">Second string.</param>
    /// <returns>The number of characters common to the start of each string.</returns>
    public static int CommonPrefix(string text1, string text2)
    {
        // Performance analysis: https://neil.fraser.name/news/2007/10/09/
        var n = Math.Min(text1.Length, text2.Length);
        for (var i = 0; i < n; i++)
        {
            if (text1[i] != text2[i])
            {
                return i;
            }
        }

        return n;
    }

    /// <summary>
    /// Determine the common suffix of two strings.
    /// </summary>
    /// <param name="text1">First string.</param>
    /// <param name="text2">Second string.</param>
    /// <returns>The number of characters common to the end of each string.</returns>
    public static int CommonSuffix(string text1, string text2)
    {
        // Performance analysis: https://neil.fraser.name/news/2007/10/09/
        var text1Length = text1.Length;
        var text2Length = text2.Length;
        var n = Math.Min(text1.Length, text2.Length);
        for (var i = 1; i <= n; i++)
        {
            if (text1[text1Length - i] != text2[text2Length - i])
            {
                return i - 1;
            }
        }

        return n;
    }

    /// <summary>
    /// Determine if the suffix of one string is the prefix of another.
    /// </summary>
    /// <param name="text1">First string.</param>
    /// <param name="text2">Second string.</param>
    /// <returns>The number of characters common to the end of the first
    /// string and the start of the second string.
    /// </returns>
    static protected int CommonOverlap(string text1, string text2)
    {
        // Cache the text lengths to prevent multiple calls.
        var text1Length = text1.Length;
        var text2Length = text2.Length;
        // Eliminate the null case.
        if (text1Length == 0 || text2Length == 0)
        {
            return 0;
        }

        // Truncate the longer string.
        if (text1Length > text2Length)
        {
            text1 = text1[(text1Length - text2Length)..];
        }
        else if (text1Length < text2Length)
        {
            text2 = text2[..text1Length];
        }

        var textLength = Math.Min(text1Length, text2Length);
        // Quick check for the worst case.
        if (text1 == text2)
        {
            return textLength;
        }

        // Start by looking for a single character match
        // and increase length until no match is found.
        // Performance analysis: https://neil.fraser.name/news/2010/11/04/
        var best = 0;
        var length = 1;
        while (true)
        {
            var pattern = text1[(textLength - length)..];
            var found = text2.IndexOf(pattern, StringComparison.Ordinal);
            if (found == -1)
            {
                return best;
            }

            length += found;
            if (found != 0 && text1[(textLength - length)..] != text2[..length])
            {
                continue;
            }

            best = length;
            length++;
        }
    }

    /// <summary>
    ///  Do the two texts share a Substring which is at least half the length of
    ///  the longer text?
    ///  This speedup can produce non-minimal diffs.
    /// </summary>
    /// <param name="text1">First string.</param>
    /// <param name="text2">Second string.</param>
    /// <returns>Five element String array, containing the prefix of text1, the
    /// suffix of text1, the prefix of text2, the suffix of text2 and the
    /// common middle.  Or null if there was no match.
    /// </returns>
    protected string[] HalfMatch(string text1, string text2)
    {
        if (this.DiffTimeout <= 0)
        {
            // Don't risk returning a non-optimal diff if we have unlimited time.
            return [];
        }

        var longtext = text1.Length > text2.Length ? text1 : text2;
        var shortText = text1.Length > text2.Length ? text2 : text1;
        if (longtext.Length < 4 || shortText.Length * 2 < longtext.Length)
        {
            return []; // Pointless.
        }

        // First check if the second quarter is the seed for a half-match.
        var hm1 = this.HalfMatchI(longtext, shortText, (longtext.Length + 3) / 4);
        // Check again based on the third quarter.
        var hm2 = this.HalfMatchI(longtext, shortText, (longtext.Length + 1) / 2);
        string[] hm;
        if (hm1 == null && hm2 == null)
        {
            return [];
        }

        if (hm2 == null)
        {
            hm = hm1;
        }
        else if (hm1 == null)
        {
            hm = hm2;
        }
        else
        {
            // Both matched.  Select the longest.
            hm = hm1[4].Length > hm2[4].Length ? hm1 : hm2;
        }

        // A half-match was found, sort out the return data.
        return text1.Length > text2.Length ? hm : [hm[2], hm[3], hm[0], hm[1], hm[4]];
    }

    /// <summary>
    /// Does a Substring of shortText exist within longtext such that the
    /// Substring is at least half the length of longtext?
    /// </summary>
    /// <param name="longtext">Longer string.</param>
    /// <param name="shortText">Shorter string.</param>
    /// <param name="i">Start index of quarter length Substring within longtext.</param>
    /// <returns>Five element string array, containing the prefix of longtext, the
    /// suffix of longtext, the prefix of shortText, the suffix of shortText
    /// and the common middle.Or null if there was no match.</returns>
    private string[] HalfMatchI(string longtext, string shortText, int i)
    {
        // Start with a 1/4 length Substring at position i as a seed.
        var seed = longtext.Substring(i, longtext.Length / 4);
        var j = -1;
        var bestCommon = string.Empty;
        string bestLongtextA = string.Empty, bestLongtextB = string.Empty;
        string bestShortTextA = string.Empty, bestShortTextB = string.Empty;
        while (j < shortText.Length && (j = shortText.IndexOf(seed, j + 1, StringComparison.Ordinal)) != -1)
        {
            var prefixLength = CommonPrefix(longtext[i..], shortText[j..]);
            var suffixLength = CommonSuffix(longtext[..i], shortText[..j]);
            if (bestCommon.Length >= suffixLength + prefixLength)
            {
                continue;
            }

            bestCommon = string.Concat(shortText.AsSpan(j - suffixLength, suffixLength)
                , shortText.AsSpan(j, prefixLength));
            bestLongtextA = longtext[..(i - suffixLength)];
            bestLongtextB = longtext[(i + prefixLength)..];
            bestShortTextA = shortText[..(j - suffixLength)];
            bestShortTextB = shortText[(j + prefixLength)..];
        }

        return bestCommon.Length * 2 >= longtext.Length
                   ? [bestLongtextA, bestLongtextB, bestShortTextA, bestShortTextB, bestCommon]
                   : [];
    }

    /// <summary>
    /// Reduce the number of edits by eliminating semantically trivial
    /// equalities.
    /// </summary>
    /// <param name="diffs">List of Diff objects.</param>
    public void CleanupSemantic(List<Diff> diffs)
    {
        var changes = false;
        // Stack of indices where equalities are found.
        var equalities = new Stack<int>();
        // Always equal to equalities[equalitiesLength-1][1]
        string lastEquality = null;
        var pointer = 0; // Index of current position.
        // Number of characters that changed prior to the equality.
        var lengthInsertions1 = 0;
        var lengthDeletions1 = 0;
        // Number of characters that changed after the equality.
        var lengthInsertions2 = 0;
        var length = 0;
        while (pointer < diffs.Count)
        {
            if (diffs[pointer].Operation == Operation.Equal)
            {
                // Equality found.
                equalities.Push(pointer);
                lengthInsertions1 = lengthInsertions2;
                lengthDeletions1 = length;
                lengthInsertions2 = 0;
                length = 0;
                lastEquality = diffs[pointer].Text;
            }
            else
            {
                // an insertion or deletion
                if (diffs[pointer].Operation == Operation.Insert)
                {
                    lengthInsertions2 += diffs[pointer].Text.Length;
                }
                else
                {
                    length += diffs[pointer].Text.Length;
                }

                // Eliminate an equality that is smaller or equal to the edits on both
                // sides of it.
                if (lastEquality != null && lastEquality.Length <= Math.Max(lengthInsertions1, lengthDeletions1)
                                         && lastEquality.Length <= Math.Max(
                                             lengthInsertions2,
                                             length))
                {
                    // Duplicate record.
                    diffs.Insert(equalities.Peek(), new Diff(Operation.Delete, lastEquality));
                    // Change second copy to insert.
                    diffs[equalities.Peek() + 1].Operation = Operation.Insert;
                    // Throw away the equality we just deleted.
                    equalities.Pop();
                    if (equalities.Count > 0)
                    {
                        equalities.Pop();
                    }

                    pointer = equalities.Count > 0 ? equalities.Peek() : -1;
                    lengthInsertions1 = 0; // Reset the counters.
                    lengthDeletions1 = 0;
                    lengthInsertions2 = 0;
                    length = 0;
                    lastEquality = null;
                    changes = true;
                }
            }

            pointer++;
        }

        // Normalize the diff.
        if (changes)
        {
            CleanupMerge(diffs);
        }

        this.CleanupSemanticLossless(diffs);

        // Find any overlaps between deletions and insertions.
        // e.g: <del>abcxxx</del><ins>xxxdef</ins>
        //   -> <del>abc</del>xxx<ins>def</ins>
        // e.g: <del>xxxabc</del><ins>defxxx</ins>
        //   -> <ins>def</ins>xxx<del>abc</del>
        // Only extract an overlap if it is as big as the edit ahead or behind it.
        pointer = 1;
        while (pointer < diffs.Count)
        {
            if (diffs[pointer - 1].Operation == Operation.Delete && diffs[pointer].Operation == Operation.Insert)
            {
                var deletion = diffs[pointer - 1].Text;
                var insertion = diffs[pointer].Text;
                var overlapLength1 = CommonOverlap(deletion, insertion);
                var overlapLength2 = CommonOverlap(insertion, deletion);
                if (overlapLength1 >= overlapLength2)
                {
                    if (overlapLength1 >= deletion.Length / 2.0 || overlapLength1 >= insertion.Length / 2.0)
                    {
                        // Overlap found.
                        // Insert an equality and trim the surrounding edits.
                        diffs.Insert(pointer, new Diff(Operation.Equal, insertion[..overlapLength1]));
                        diffs[pointer - 1].Text = deletion[..^overlapLength1];
                        diffs[pointer + 1].Text = insertion[overlapLength1..];
                        pointer++;
                    }
                }
                else
                {
                    if (overlapLength2 >= deletion.Length / 2.0 || overlapLength2 >= insertion.Length / 2.0)
                    {
                        // Reverse overlap found.
                        // Insert an equality and swap and trim the surrounding edits.
                        diffs.Insert(pointer, new Diff(Operation.Equal, deletion[..overlapLength2]));
                        diffs[pointer - 1].Operation = Operation.Insert;
                        diffs[pointer - 1].Text = insertion[..^overlapLength2];
                        diffs[pointer + 1].Operation = Operation.Delete;
                        diffs[pointer + 1].Text = deletion[overlapLength2..];
                        pointer++;
                    }
                }

                pointer++;
            }

            pointer++;
        }
    }

    /// <summary>
    /// Look for single edits surrounded on both sides by equalities
    /// which can be shifted sideways to align the edit to a word boundary.
    /// e.g: The c<ins>at c</ins>ame. -> The <ins>cat </ins>came.
    /// </summary>
    /// <param name="diffs">List of Diff objects.</param>
    public void CleanupSemanticLossless(List<Diff> diffs)
    {
        var pointer = 1;
        // Intentionally ignore the first and last element (don't need checking).
        while (pointer < diffs.Count - 1)
        {
            if (diffs[pointer - 1].Operation == Operation.Equal && diffs[pointer + 1].Operation == Operation.Equal)
            {
                // This is a single edit surrounded by equalities.
                var equality1 = diffs[pointer - 1].Text;
                var edit = diffs[pointer].Text;
                var equality2 = diffs[pointer + 1].Text;

                // First, shift the edit as far left as possible.
                var commonOffset = CommonSuffix(equality1, edit);
                if (commonOffset > 0)
                {
                    var commonString = edit[^commonOffset..];
                    equality1 = equality1[..^commonOffset];
                    edit = commonString + edit[..^commonOffset];
                    equality2 = commonString + equality2;
                }

                // Second, step character by character right,
                // looking for the best fit.
                var bestEquality1 = equality1;
                var bestEdit = edit;
                var bestEquality2 = equality2;
                var bestScore = this.CleanupSemanticScore(equality1, edit)
                                + this.CleanupSemanticScore(edit, equality2);
                while (edit.Length != 0 && equality2.Length != 0 && edit[0] == equality2[0])
                {
                    equality1 += edit[0];
                    edit = edit[1..] + equality2[0];
                    equality2 = equality2[1..];
                    var score = this.CleanupSemanticScore(equality1, edit)
                                + this.CleanupSemanticScore(edit, equality2);
                    // The >= encourages trailing rather than leading whitespace on
                    // edits.
                    if (score < bestScore)
                    {
                        continue;
                    }

                    bestScore = score;
                    bestEquality1 = equality1;
                    bestEdit = edit;
                    bestEquality2 = equality2;
                }

                if (diffs[pointer - 1].Text != bestEquality1)
                {
                    // We have an improvement, save it back to the diff.
                    if (bestEquality1.Length != 0)
                    {
                        diffs[pointer - 1].Text = bestEquality1;
                    }
                    else
                    {
                        diffs.RemoveAt(pointer - 1);
                        pointer--;
                    }

                    diffs[pointer].Text = bestEdit;
                    if (bestEquality2.Length != 0)
                    {
                        diffs[pointer + 1].Text = bestEquality2;
                    }
                    else
                    {
                        diffs.RemoveAt(pointer + 1);
                        pointer--;
                    }
                }
            }

            pointer++;
        }
    }

    /// <summary>
    /// Given two strings, compute a score representing whether the internal
    /// boundary falls on logical boundaries.
    /// Scores range from 6 (best) to 0 (worst).
    /// </summary>
    /// <param name="one">First string.</param>
    /// <param name="two">Second string.</param>
    /// <returns>The score.</returns>
    private int CleanupSemanticScore(string one, string two)
    {
        if (one.Length == 0 || two.Length == 0)
        {
            // Edges are the best.
            return 6;
        }

        // Each port of this function behaves slightly differently due to
        // subtle differences in each language's definition of things like
        // 'whitespace'.  Since this function's purpose is largely cosmetic,
        // the choice has been made to use each language's native features
        // rather than force total conformity.
        var char1 = one[^1];
        var char2 = two[0];
        var nonAlphaNumeric1 = !char.IsLetterOrDigit(char1);
        var nonAlphaNumeric2 = !char.IsLetterOrDigit(char2);
        var whitespace1 = nonAlphaNumeric1 && char.IsWhiteSpace(char1);
        var whitespace2 = nonAlphaNumeric2 && char.IsWhiteSpace(char2);
        var lineBreak1 = whitespace1 && char.IsControl(char1);
        var lineBreak2 = whitespace2 && char.IsControl(char2);
        var blankLine1 = lineBreak1 && this.blankLineEnd.IsMatch(one);
        var blankLine2 = lineBreak2 && this.blankLineStart.IsMatch(two);

        if (blankLine1 || blankLine2)
        {
            // Five points for blank lines.
            return 5;
        }

        if (lineBreak1 || lineBreak2)
        {
            // Four points for line breaks.
            return 4;
        }

        if (nonAlphaNumeric1 && !whitespace1 && whitespace2)
        {
            // Three points for end of sentences.
            return 3;
        }

        if (whitespace1 || whitespace2)
        {
            // Two points for whitespace.
            return 2;
        }

        if (nonAlphaNumeric1 || nonAlphaNumeric2)
        {
            // One point for non-alphanumeric.
            return 1;
        }

        return 0;
    }

    // Define some regex patterns for matching boundaries.
    private readonly Regex blankLineEnd = new(@"\n\r?\n\Z", RegexOptions.None, TimeSpan.FromMilliseconds(100));

    private readonly Regex blankLineStart = new(@"\A\r?\n\r?\n", RegexOptions.None, TimeSpan.FromMilliseconds(100));

    /// <summary>
    /// Reorder and merge like edit sections.  Merge equalities.
    /// Any edit section can move as long as it doesn't cross an equality.
    /// </summary>
    /// <param name="diffs">List of Diff objects.</param>
    public static void CleanupMerge(List<Diff> diffs)
    {
        while (true)
        {
            // Add a dummy entry at the end.
            diffs.Add(new Diff(Operation.Equal, string.Empty));
            var pointer = 0;
            var countDelete = 0;
            var countInsert = 0;
            var textDelete = string.Empty;
            var textInsert = string.Empty;
            while (pointer < diffs.Count)
            {
                switch (diffs[pointer].Operation)
                {
                    case Operation.Insert:
                        countInsert++;
                        textInsert += diffs[pointer].Text;
                        pointer++;
                        break;
                    case Operation.Delete:
                        countDelete++;
                        textDelete += diffs[pointer].Text;
                        pointer++;
                        break;
                    case Operation.Equal:
                        // Upon reaching an equality, check for prior redundancies.
#pragma warning disable S2583 // Conditionally executed code should be reachable
                        if (countDelete + countInsert > 1)
                        {
                            if (countDelete != 0 && countInsert != 0)
                            {
                                // Factor out any common prefixes.
                                var commonLength = CommonPrefix(textInsert, textDelete);
                                if (commonLength != 0)
                                {
                                    if (pointer - countDelete - countInsert > 0 && diffs[pointer - countDelete - countInsert - 1].Operation == Operation.Equal)
                                    {
                                        diffs[pointer - countDelete - countInsert - 1].Text += textInsert[..commonLength];
                                    }
                                    else
                                    {
                                        diffs.Insert(0, new Diff(Operation.Equal, textInsert[..commonLength]));
                                        pointer++;
                                    }

                                    textInsert = textInsert[commonLength..];
                                    textDelete = textDelete[commonLength..];
                                }

                                // Factor out any common suffixes.
                                commonLength = CommonSuffix(textInsert, textDelete);
                                if (commonLength != 0)
                                {
                                    diffs[pointer].Text = textInsert[^commonLength..] + diffs[pointer].Text;
                                    textInsert = textInsert[..^commonLength];
                                    textDelete = textDelete[..^commonLength];
                                }
                            }

                            // Delete the offending records and add the merged ones.
                            pointer -= countDelete + countInsert;
                            diffs.Splice(pointer, countDelete + countInsert);
                            if (textDelete.Length != 0)
                            {
                                diffs.Splice(pointer, 0, new Diff(Operation.Delete, textDelete));
                                pointer++;
                            }

                            if (textInsert.Length != 0)
                            {
                                diffs.Splice(pointer, 0, new Diff(Operation.Insert, textInsert));
                                pointer++;
                            }

                            pointer++;
                        }
                        else if (pointer != 0 && diffs[pointer - 1].Operation == Operation.Equal)
                        {
                            // Merge this equality with the previous one.
                            diffs[pointer - 1].Text += diffs[pointer].Text;
                            diffs.RemoveAt(pointer);
                        }
                        else
                        {
                            pointer++;
                        }
#pragma warning restore S2583 // Conditionally executed code should be reachable

                        countInsert = 0;
                        countDelete = 0;
                        textDelete = string.Empty;
                        textInsert = string.Empty;
                        break;
                }
            }

            if (diffs[^1].Text.Length == 0)
            {
                diffs.RemoveAt(diffs.Count - 1); // Remove the dummy entry at the end.
            }

            // Second pass: look for single edits surrounded on both sides by
            // equalities which can be shifted sideways to eliminate an equality.
            // e.g: A<ins>BA</ins>C -> <ins>AB</ins>AC
            var changes = false;
            pointer = 1;
            // Intentionally ignore the first and last element (don't need checking).
            while (pointer < diffs.Count - 1)
            {
                if (diffs[pointer - 1].Operation == Operation.Equal && diffs[pointer + 1].Operation == Operation.Equal)
                {
                    // This is a single edit surrounded by equalities.
                    if (diffs[pointer].Text.EndsWith(diffs[pointer - 1].Text, StringComparison.Ordinal))
                    {
                        // Shift the edit over the previous equality.
                        diffs[pointer].Text = diffs[pointer - 1].Text + diffs[pointer].Text[..^diffs[pointer - 1].Text.Length];
                        diffs[pointer + 1].Text = diffs[pointer - 1].Text + diffs[pointer + 1].Text;
                        diffs.Splice(pointer - 1, 1);
                        changes = true;
                    }
                    else if (diffs[pointer].Text.StartsWith(diffs[pointer + 1].Text, StringComparison.Ordinal))
                    {
                        // Shift the edit over the next equality.
                        diffs[pointer - 1].Text += diffs[pointer + 1].Text;
                        diffs[pointer].Text = diffs[pointer].Text[diffs[pointer + 1].Text.Length..] + diffs[pointer + 1].Text;
                        diffs.Splice(pointer + 1, 1);
                        changes = true;
                    }
                }

                pointer++;
            }

            // If shifts were made, the diff needs reordering and another shift sweep.
            if (changes)
            {
                continue;
            }

            break;
        }
    }

    /// <summary>
    /// Convert a Diff list into a pretty HTML report.
    /// </summary>
    /// <param name="diffs">List of Diff objects.</param>
    /// <returns>HTML representation.</returns>
    public static string PrettyHtml(List<Diff> diffs)
    {
        var html = new StringBuilder();
        foreach (var aDiff in diffs)
        {
            var text = aDiff.Text.Replace("&", "&amp;").Replace("<", "&lt;").Replace(">", "&gt;")
                .Replace("\n", "<br>");
            switch (aDiff.Operation)
            {
                case Operation.Insert:
                    html.Append("<p class=\"bg-success text-light\">").Append(text).Append("</p>");
                    break;
                case Operation.Delete:
                    html.Append("<p class=\"bg-danger text-light\">").Append(text).Append("</p>");
                    break;
                case Operation.Equal:
                    html.Append("<p>").Append(text).Append("</p>");
                    break;
            }
        }

        return html.ToString();
    }
}