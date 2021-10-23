﻿<%@ Control Language="C#" AutoEventWireup="true" Inherits="YAF.Pages.Admin.ReIndex" Codebehind="ReIndex.ascx.cs" %>

<YAF:PageLinks runat="server" ID="PageLinks" />

<div class="row">
    <div class="col-xl-12">
        <div class="card mb-3">
            <div class="card-header">
                <YAF:IconHeader runat="server"
                                IconName="database"
                                LocalizedTag="admin_reindex"
                                LocalizedPage="ADMINMENU"></YAF:IconHeader>
            </div>
            <div class="card-body">
                <asp:TextBox ID="txtIndexStatistics" runat="server"
                             Height="400px"
                             TextMode="MultiLine"
                    CssClass="form-control"></asp:TextBox>
                <asp:Placeholder ID="PanelGetStats" runat="server" Visible="False">
                    <p class="card-text">
                        <YAF:LocalizedLabel ID="LocalizedLabel2" runat="server"
                                            LocalizedTag="SHOW_STATS"
                                            LocalizedPage="ADMIN_REINDEX" />
                    </p>
                    <p class="card-text">
                        <YAF:ThemeButton ID="GetStats"
                                         Type="Primary" runat="server"
                                         OnClick="GetStatsClick"
                                         Icon="database"
                                         TextLocalizedTag="TBLINDEXSTATS_BTN" />
                    </p>
                    <hr />
                </asp:Placeholder>
                <asp:Placeholder ID="PanelRecoveryMode" runat="server" Visible="False">
                    <p class="card-text">
                        <YAF:ThemeButton ID="RecoveryMode" Type="Primary" runat="server" OnClick="RecoveryModeClick"
                                         Icon="database" TextLocalizedTag="SETRECOVERY_BTN" />
                        <div class="form-check form-check-inline">
                            <asp:RadioButtonList ID="RadioButtonList1" runat="server"
                                                 RepeatLayout="UnorderedList"
                                                 CssClass="list-unstyled">
                            </asp:RadioButtonList>
                        </div>
                    </p>
                    <hr />
                </asp:Placeholder>
                <asp:Placeholder ID="PanelReindex" runat="server" Visible="False">
                    <p class="card-text">
                        <YAF:LocalizedLabel ID="LocalizedLabel4" runat="server" LocalizedTag="REINDEX" LocalizedPage="ADMIN_REINDEX" />
                    </p>
                    <p class="card-text">
                        <YAF:ThemeButton ID="Reindex" Type="Primary" runat="server"
                                         OnClick="ReindexClick"
                                         Icon="database" TextLocalizedTag="REINDEXTBL_BTN" />
                    </p>
                    <hr />
                </asp:Placeholder>
                <asp:Placeholder ID="PanelShrink" runat="server" Visible="False">
                    <p class="card-text">
                        <YAF:LocalizedLabel ID="LocalizedLabel3" runat="server" LocalizedTag="SHRINK" LocalizedPage="ADMIN_REINDEX" />
                    </p>
                    <p class="card-text">
                        <YAF:ThemeButton ID="Shrink" runat="server"
                                         OnClick="ShrinkClick"
                                         Type="Primary"
                                         Icon="database"
                                         TextLocalizedTag="SHRINK_BTN" />
                    </p>
                </asp:Placeholder>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="DeleteForumMessage" aria-hidden="true" aria-labelledby="MessageToggleLabel" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <YAF:LocalizedLabel ID="LocalizedLabel6" runat="server" LocalizedTag="REINDEX_TITLE" LocalizedPage="ADMIN_REINDEX" />
            </div>
            <div class="modal-body text-center">
                <YAF:LocalizedLabel ID="LocalizedLabel7" runat="server" LocalizedTag="REINDEX_MSG" LocalizedPage="ADMIN_REINDEX" />
                <div class="fa-3x"><i class="fas fa-spinner fa-pulse"></i></div>
            </div>
        </div>
    </div>
</div>