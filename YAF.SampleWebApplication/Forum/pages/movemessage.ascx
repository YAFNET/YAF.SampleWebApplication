﻿<%@ Control Language="c#" AutoEventWireup="True" Inherits="YAF.Pages.MoveMessage" Codebehind="MoveMessage.ascx.cs" %>


<YAF:PageLinks runat="server" ID="PageLinks" />

<div class="row">
    <div class="col-xl-12">
        <h2><YAF:LocalizedLabel ID="LocalizedLabel7" runat="server" LocalizedTag="TITLE" /></h2>
    </div>
</div>

<div class="row">
    <div class="col">
        <div class="card mb-3">
            <div class="card-header">
                <YAF:IconHeader runat="server"
                                IconName="arrows-alt"
                                LocalizedTag="MOVE_TITLE"/>
            </div>
            <div class="card-body text-center">
                <div class="mb-3">
                    <asp:Label runat="server" AssociatedControlID="ForumList">
                        <YAF:LocalizedLabel ID="LocalizedLabel2" runat="server" 
                                            LocalizedTag="select_forum_moveto" />
                    </asp:Label>
                    <asp:DropDownList ID="ForumList" runat="server" 
                                      CssClass="select2-image-select" 
                                      AutoPostBack="True" 
                                      OnSelectedIndexChanged="ForumList_SelectedIndexChanged" />
                </div>
                <div class="mb-3">
                    <asp:Label runat="server" AssociatedControlID="TopicsList">
                        <YAF:LocalizedLabel ID="LocalizedLabel3" runat="server" 
                                            LocalizedTag="select_topic_moveto" />
                    </asp:Label>
                    <asp:DropDownList ID="TopicsList" runat="server" 
                                      OnSelectedIndexChanged="TopicsList_SelectedIndexChanged" />
                </div>
            </div>
            <div class="card-footer text-center">
                <YAF:ThemeButton ID="Move" runat="server" 
                                 OnClick="Move_Click"
                                 TextLocalizedTag="MOVE_MESSAGE"
                                 TitleLocalizedTag="MOVE_TITLE"
                                 Icon="arrows-alt"/>
            </div>
        </div>
    </div>
    <div class="col">
        <div class="card mb-3">
            <div class="card-header">
                <YAF:IconHeader runat="server"
                                IconName="cut"
                                LocalizedTag="SPLIT_TITLE"/>
            </div>
            <div class="card-body text-center">
                <div class="mb-3">
                    <asp:Label runat="server" AssociatedControlID="TopicSubject">
                        <YAF:LocalizedLabel ID="LocalizedLabel4" runat="server" 
                                            LocalizedTag="new_topic" />
                    </asp:Label>
                    <asp:TextBox ID="TopicSubject" runat="server" CssClass="form-control" />
                </div>
            </div>
            <div class="card-footer text-center">
                <YAF:ThemeButton ID="CreateAndMove" runat="server" 
                                 OnClick="CreateAndMove_Click"
                                 TextLocalizedTag="CREATE_TOPIC"
                                 TitleLocalizedTag="SPLIT_TITLE"
                                 Type="Secondary"
                                 Icon="cut"/>
            </div>
        </div>
    </div>
</div>