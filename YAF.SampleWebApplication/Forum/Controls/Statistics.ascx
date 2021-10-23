﻿<%@ Control Language="C#" AutoEventWireup="true" EnableViewState="false" Inherits="YAF.Controls.Statistics" Codebehind="Statistics.ascx.cs" %>

        <div class="card mb-3">
            <div class="card-header d-flex align-items-center">
                <YAF:IconHeader runat="server"
                                IconName="chart-bar"
                                IconSize="fa-2x"
                                LocalizedTag="STATS" />
            </div>
            <div class="row">
                    <div class="col">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">
                                <asp:Label ID="StatsPostsTopicCount" runat="server" />
                            </li>
                            <asp:PlaceHolder runat="server" ID="StatsLastPostHolder" Visible="False">
                                <li class="list-group-item">
                                    <asp:Label ID="StatsLastPost" runat="server"
                                               CssClass="me-2" /><YAF:UserLink ID="LastPostUserLink" runat="server" />
                                </li>
                            </asp:PlaceHolder>
                            <li class="list-group-item">
                                <asp:Label ID="StatsMembersCount" runat="server" />
                            </li>
                            <li class="list-group-item">
                                <asp:Label ID="StatsNewestMember" runat="server"
                                           CssClass="me-2" /><YAF:UserLink ID="NewestMemberUserLink" runat="server" />
                            </li>
                        </ul>
                    </div>
                    <asp:PlaceHolder runat="server" ID="AntiSpamStatsHolder">
                        <div class="col-md-6">
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item">
                                    <h6 class="fw-bold">
                                        <YAF:LocalizedLabel runat="server"
                                                            LocalizedTag="STATS_SPAM">
                                        </YAF:LocalizedLabel>
                                    </h6>
                                </li>
                                <li class="list-group-item">
                                    <YAF:LocalizedLabel runat="server" ID="StatsSpamDenied"
                                                        LocalizedTag="STATS_SPAM_DENIED"></YAF:LocalizedLabel>
                                </li>
                                <li class="list-group-item">
                                    <YAF:LocalizedLabel runat="server" ID="StatsSpamBanned"
                                                        LocalizedTag="STATS_SPAM_BANNED"></YAF:LocalizedLabel>
                                </li>
                                <li class="list-group-item">
                                    <YAF:LocalizedLabel runat="server" ID="StatsSpamReported"
                                                        LocalizedTag="STATS_SPAM_REPORTED"></YAF:LocalizedLabel>
                                </li>
                            </ul>
                        </div>
                    </asp:PlaceHolder>
                </div>
        </div>