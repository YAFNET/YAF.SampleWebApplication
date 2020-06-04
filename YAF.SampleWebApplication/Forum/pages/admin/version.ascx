﻿<%@ Control Language="c#" AutoEventWireup="True" Inherits="YAF.Pages.Admin.version"
    CodeBehind="version.ascx.cs" %>


<YAF:PageLinks runat="server" ID="PageLinks" />
    <div class="row">
    <div class="col-xl-12">
         <h1><yaf:LocalizedLabel id="LocalizedLabel1" runat="server" 
                                 LocalizedTag="TITLE" 
                                 Localizedpage="ADMIN_VERSION"></yaf:LocalizedLabel></h1>
    </div>
</div>
<div class="row">
    <div class="col-xl-12">
        <div class="card mb-3">
            <div class="card-header">
                <i class="fa fa-info fa-fw text-secondary"></i>&nbsp;
                <yaf:LocalizedLabel id="LocalizedLabel2" runat="server" 
                                    LocalizedTag="TITLE" 
                                    LocalizedPage="ADMIN_VERSION"></yaf:LocalizedLabel>
            </div>
            <div class="card-body">
                <asp:PlaceHolder runat="server" id="UpgradeVersionHolder" visible="false">
                    <YAF:Alert runat="server" Type="info">
                        <YAF:Icon runat="server" IconName="box-open" IconType="text-info"></YAF:Icon>
                        <YAF:LocalizedLabel runat="server"
                                            LocalizedTag="NEW_VERSION"></YAF:LocalizedLabel>
                        <YAF:ThemeButton runat="server" ID="Download"
                                         TextLocalizedTag="UPGRADE_VERSION"
                                         Type="Info"
                                         Icon="cloud-download-alt"></YAF:ThemeButton>
                    </YAF:Alert>
                </asp:PlaceHolder>
                <p class="card-text">
                    <svg class="p-5 float-left" style="height:140px"  xmlns="http://www.w3.org/2000/svg" viewBox="0 0 4615.94 2142.98"><title>YAFLogo</title><g id="Layer_2" data-name="Layer 2"><path d="M1879.13,59.73,1058.13.54C944-7.68,844,79,835.72,193.05l-18,249.73L909,435.24l17-235.69c4.62-64.07,61.63-113.41,125.7-108.78l821,59.17c64.06,4.63,113.38,61.64,108.78,125.69l-45.5,631.18a115.28,115.28,0,0,1-11,41.55L2016,964a206.23,206.23,0,0,0,10.1-50.65l45.51-631.17C2079.84,168,1993.23,67.94,1879.13,59.73Z" transform="translate(0 0)" style="fill:#4e4596;fill-rule:evenodd"/><path d="M1063.38,1617.35q3.16-20.26,6.34-40.55l-240.41,28.69-207.44,155.2-15.35-128.61L373.37,1659.9c-83.83,10-161-50.73-171-134.56l-94.12-788.6c-10-83.83,50.74-161,134.56-171l1025.74-122.4c83.83-10,161,50.72,171,134.56s20,168,30.07,252L1579.58,847,1546,565.17c-17-142.56-147.56-245.27-290.12-228.26L230.1,459.32C87.55,476.33-15.16,606.88,1.84,749.44L96,1538c17,142.56,147.57,245.27,290.12,228.26l126.76-15.13,24.63,206.51,333-249.19,193.56-23.1A206.21,206.21,0,0,1,1063.38,1617.35Z" transform="translate(0 0)" style="fill:#3a60aa"/><path d="M2221.77,958.74,1589.4,859.92l-110-17.18-70.93-11.08c-113-17.67-220,60.35-237.61,173.37q-45.68,292.37-91.37,584.69l-6.33,40.55a206.22,206.22,0,0,0,.68,68c15.13,85.08,82.85,155.52,172.71,169.58l429.15,67.06,258,208,25.58-163.72,100.5,15.7c113,17.66,220-60.36,237.6-173.38l97.71-625.23C2412.8,1083.32,2334.78,976.4,2221.77,958.74Zm84,223.64-97.7,625.23c-9.91,63.44-70.83,107.91-134.27,98l-189.87-29.66-15.36,98.31-154.92-124.92-453.09-70.81c-48.68-7.61-86.17-45.22-96.52-91a115.41,115.41,0,0,1-1.48-43.29q5.14-32.84,10.27-65.67,43.73-279.78,87.44-559.58c9.92-63.46,70.82-107.89,134.27-98l96,15,110,17.19,607.26,94.89C2271.25,1058,2315.69,1118.94,2305.77,1182.38Z" transform="translate(0 0)" style="fill:#d43342"/></g><g id="Ebene_2" data-name="Ebene 2"><path d="M2916,1274.49c0,95.2-79.1,173.6-175,173.6v-65.8c60.21,0,108.5-48.3,108.5-107.8v-32.9c-29.4,24.5-67.2,38.5-108.5,38.5-95.89,0-172.19-79.8-174.29-175V934.29h65.1v171.5c0,60.2,49,108.5,109.19,108.5a108.14,108.14,0,0,0,108.5-108.5V934.29H2916Z" transform="translate(0 0)" style="fill:#3a60aa"/><path d="M3373.84,1279.39c-38.5-6.3-67.9-36.4-88.9-67.2-32.2,42.7-82.6,68.6-139.3,68.6-96.6,0-175-78.4-175-175.7,0-96.6,78.4-174.3,175-174.3,97.3,0,174.3,77.7,174.3,174.3v14.7c0,39.2,21.7,77,53.9,93.8Zm-228.2-282.1c-60.9,0-109.2,47.6-109.2,107.8,0,60.9,48.3,109.9,109.2,109.9s108.5-49,108.5-109.9C3254.14,1044.89,3206.54,997.29,3145.64,997.29Z" transform="translate(0 0)" style="fill:#3a60aa"/><path d="M3462.73,932.89l-.7.7h98.7v65.8H3462l.7,281.4h-65.1V931.49a173.87,173.87,0,0,1,174.3-174.3v65.1C3511.73,822.29,3462.73,872.69,3462.73,932.89Z" transform="translate(0 0)" style="fill:#3a60aa"/><path d="M3590.82,1240.8a46.38,46.38,0,0,1,46.14-46.14q18.79,0,32.47,13.67t13.67,32.47a46.28,46.28,0,0,1-78.78,32.81Q3590.82,1260.28,3590.82,1240.8Z" transform="translate(0 0)" style="fill:#444342"/><path d="M3704.43,827.91l322,330.95V845.34h59.48V1301l-322-329.48v309.32h-59.47Z" transform="translate(0 0)" style="fill:#444342"/><path d="M4117.46,845.34h241.31v59.47H4176.25V1013.5h182.52v58.79H4176.25V1222h182.52v58.79H4117.46Z" transform="translate(0 0)" style="fill:#444342"/><path d="M4349.68,845.34h266.26v59.47H4512v376h-58.79v-376H4349.68Z" transform="translate(0 0)" style="fill:#444342"/></g></svg>
                </p>
                    <p class="card-text">
                        <asp:label id="RunningVersion" runat="server"></asp:label>
                    </p>
                    <p class="card-text">
                        <asp:label id="LatestVersion" runat="server"></asp:label>
                    </p>
            </div>
        </div>
    </div>
</div>

