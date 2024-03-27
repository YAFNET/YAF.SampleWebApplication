﻿<%@ Control Language="C#" AutoEventWireup="True" EnableViewState="false" CodeBehind="PollList.ascx.cs"
    Inherits="YAF.Controls.PollList" %>
<%@ Import Namespace="YAF.Types.Interfaces" %>
<%@ Import Namespace="YAF.Core.Helpers" %>
<%@ Register TagPrefix="YAF" TagName="PollChoiceList" Src="PollChoiceList.ascx" %>


<asp:PlaceHolder id="PollListHolder" runat="server" Visible="true">
    <div class="row">
        <div class="col">
            <div class="<%# StringHelper.GetTextBgColor("card text-bg-light mb-3") %>">
                <div class="card-header">
                    <YAF:IconHeader runat="server"
                                    IconType="text-secondary"
                                    IconName="question-circle"
                                    LocalizedTag="question" />:
                    <asp:Label ID="QuestionLabel" runat="server" />
                    <asp:Label runat="server" ID="PollClosed" 
                               Visible="False"></asp:Label>
                </div>
                <div class="card-body">
                    <YAF:Alert runat="server" ID="Alert"
                               Type="info" Visible="False">
                        <YAF:Icon runat="server" 
                                  IconName="info-circle" />
                        <asp:Label ID="PollNotification" runat="server" />
                    </YAF:Alert>
                    <asp:Image id="QuestionImage" runat="server"
                               data-bs-toggle="tooltip"
                               CssClass="img-thumbnail mb-1"
                               style="max-height:80px"/>
               
                    <YAF:PollChoiceList ID="PollChoiceList1" runat="server" />
                    <p class="card-text">
                        <%= this.GetText("total") %>: <asp:Label runat="server" ID="TotalVotes"/>
                    </p>
                </div>
                <asp:PlaceHolder id="PollCommandRow" runat="server">
                    <div class="card-footer text-body-secondary">
                        <div class="row">
                            <div class="col">
                            </div>
                            <div class="col-auto d-flex flex-wrap">
                                <YAF:ThemeButton ID="EditPoll" runat="server" 
                                                 OnClick="EditClick"
                                                 Size="Small"
                                                 CssClass="me-1" 
                                                 TextLocalizedTag="EDITPOLL"
                                                 Type="Secondary"
                                                 Icon="edit"/>
                                <YAF:ThemeButton ID="RemovePoll" runat="server" 
                                                 OnClick="RemoveClick"
                                                 Visible="false" 
                                                 Size="Small"
                                                 TextLocalizedTag="REMOVEPOLL"
                                                 ReturnConfirmTag="ASK_POLL_DELETE"
                                                 Type="Danger"
                                                 Icon="trash"/>
                            </div>
                        </div>
                    </div>
                </asp:PlaceHolder>
            </div>
        </div>
    </div>
</asp:PlaceHolder>
<asp:PlaceHolder id="NewPollRow" runat="server" visible="false">
    <div class="row">
        <div class="col">
            <YAF:ThemeButton ID="CreatePoll" runat="server"
                             TextLocalizedTag="CREATEPOLL"
                             Icon="poll-h"
                             CssClass="mb-3"
                             Type="Secondary"/>
        </div>
    </div>
</asp:PlaceHolder>