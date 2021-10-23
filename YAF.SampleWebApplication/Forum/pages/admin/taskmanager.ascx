﻿<%@ Control Language="C#" AutoEventWireup="true" Inherits="YAF.Pages.Admin.TaskManager"
    CodeBehind="TaskManager.ascx.cs" %>
<%@ Import Namespace="YAF.Types.Extensions" %>
<%@ Import Namespace="YAF.Core.Extensions" %>

<YAF:PageLinks ID="PageLinks" runat="server" />

    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-3">
                <div class="card-header">
                    <YAF:IconHeader runat="server"
                                    IconName="tasks"
                                    LocalizedTag="HEADER"
                                    LocalizedPage="ADMIN_TASKMANAGER"
                                    Param0="<%# this.Get<ITaskModuleManager>().TaskCount.ToString() %>"></YAF:IconHeader>
                    </div>
                <div class="card-body">
        <asp:Repeater ID="taskRepeater" runat="server" OnItemCommand="TaskRepeaterItemCommand">
            <HeaderTemplate>
                <ul class="list-group">
            </HeaderTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
            <ItemTemplate>
                <li class="list-group-item list-group-item-action list-group-item-menu">
                    <div class="d-flex w-100 justify-content-between">
                        <h5 class="mb-1">
                            <%# this.Eval("Key") %>
                        </h5>
                        <small class="d-none d-md-block">
                            <YAF:LocalizedLabel ID="LocalizedLabel3" runat="server" 
                                                LocalizedTag="DURATION" 
                                                LocalizedPage="ADMIN_TASKMANAGER" />:
                            <%# this.FormatTimeSpan(((KeyValuePair<string, IBackgroundTask>)Container.DataItem).Value.Started)%>
                        </small>
                    </div>
                    <p class="mb-1">
                        <YAF:LocalizedLabel ID="LocalizedLabel2" runat="server" 
                                            LocalizedTag="RUNNING" 
                                            LocalizedPage="ADMIN_TASKMANAGER" />: 
                        <asp:Label ID="Label2" runat="server" 
                                   CssClass='<%# this.GetItemColor(this.Eval("Value.IsRunning").ToType<bool>()) %>'><%# this.GetItemName(this.Eval("Value.IsRunning").ToType<bool>())%></asp:Label>
                    </p>
                    <asp:PlaceHolder ID="StopTaskHolder" runat="server" 
                                     Visible="<%# ((KeyValuePair<string, IBackgroundTask>)Container.DataItem).Value.IsStoppable() %>">
                        <small>
                            <YAF:ThemeButton ID="stop" runat="server"
                                             CommandName="stop" 
                                             CommandArgument='<%# this.Eval("Key") %>'
                                             TextLocalizedTag="STOP_TASK" TextLocalizedPage="ADMIN_TASKMANAGER"
                                             Icon="hand-paper" 
                                             Type="Danger" 
                                             Size="Small">
                            </YAF:ThemeButton>
                            <div class="dropdown-menu context-menu" aria-labelledby="context menu">
                                <YAF:ThemeButton ID="ThemeButton1" runat="server"
                                                 CommandName="stop" 
                                                 CommandArgument='<%# this.Eval("Key") %>'
                                                 TextLocalizedTag="STOP_TASK" TextLocalizedPage="ADMIN_TASKMANAGER"
                                                 Icon="hand-paper" 
                                                 Type="None"
                                                 CssClass="dropdown-item" />
                            </div>
                        </small>
                    </asp:PlaceHolder>
                </li>
            </ItemTemplate>
        </asp:Repeater>
                    </div>
            </div>
        </div>
    </div>


