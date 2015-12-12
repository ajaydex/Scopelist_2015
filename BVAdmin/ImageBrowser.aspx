<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminPopup.master" AutoEventWireup="false"
    CodeFile="ImageBrowser.aspx.vb" Inherits="BVAdmin_ImageBrowser" Title="Image Browser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BvcAdminPopupConent" runat="Server">
    <div class="imageBrowser">

        <asp:Label ID="lblError" runat="server" CssClass="errormessage"></asp:Label>

        <table cellspacing="0" cellpadding="0" border="0">
            <tr>
                <td width="370">
                    <h2>Upload a new image</h2>

                    <div class="uploadImage" style="width:350px;">
                        <div style="padding:15px;">
                            <table width="100%" cellspacing="0" cellpadding="0" border="0">
                                <tr>
                                    <td valign="top" align="left">
                                        <asp:FileUpload ID="UploadFileField" runat="server" /><br /><br />
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" align="left">
                                        <asp:CheckBox ID="chkRename" runat="server" Text="Rename Image To:"></asp:CheckBox>
                                        <asp:TextBox ID="RenameField" Columns="20" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" align="left">
                                        <asp:CheckBox ID="chkOptimize" runat="server" Text="Optimize JPEGs to < ">
                                        </asp:CheckBox><asp:DropDownList ID="lstOptimize" runat="server">
                                            <asp:ListItem Value="1">1 KB</asp:ListItem>
                                            <asp:ListItem Value="3">3 KB</asp:ListItem>
                                            <asp:ListItem Value="5" Selected="True">5 KB</asp:ListItem>
                                            <asp:ListItem Value="10">10 KB</asp:ListItem>
                                            <asp:ListItem Value="20">20 KB</asp:ListItem>
                                            <asp:ListItem Value="30">30 KB</asp:ListItem>
                                            <asp:ListItem Value="40">40 KB</asp:ListItem>
                                            <asp:ListItem Value="50">50 KB</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" align="left">
                                        <asp:RadioButton ID="rbResizeNone" runat="server" GroupName="rbResize" Text="Do not resize"
                                            Checked="True"></asp:RadioButton><br />
                                        <asp:RadioButton ID="rbResizeSmall" runat="server" GroupName="rbResize" Text="Resize to Small Size"
                                            ></asp:RadioButton><br />
                                        <asp:RadioButton ID="rbResizeMedium" runat="server" GroupName="rbResize" Text="Resize to Medium Size"
                                            ></asp:RadioButton><br />
                                        <asp:RadioButton ID="rbResizeCustom" runat="server" GroupName="rbResize" Text="Custom Size"
                                            ></asp:RadioButton>&nbsp;
                                        <asp:TextBox ID="ResizeWidthField" runat="server" CssClass="FormInput" Columns="4"></asp:TextBox>w&nbsp;
                                        <asp:TextBox ID="ResizeHeightField" runat="server" CssClass="FormInput" Columns="4"></asp:TextBox>h</td>
                                </tr>
                                <tr>
                                    <td>
                                        <br />
                                        <asp:ImageButton ID="btnUpload" runat="server" ImageUrl="~/BVadmin/images/buttons/Upload.png" ToolTip="Upload New Image"></asp:ImageButton>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </td>

                <td width="280px">
                    <h2>Select an image</h2>
                    <div style="overflow:scroll; width:260px; height:250px; background-color:#ffffff; border:1px solid #ccc;">
                        <div style="padding:10px;">
                            <asp:Repeater ID="FilesListRepeater" runat="server">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnFile" runat="server"></asp:LinkButton><br>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>

                    <div style="background:#ccc;width:260px; border:1px solid #ccc;">
                        <div style="padding:15px;">
                            Create New Folder:
                            <br />
                            <asp:TextBox runat="server" ID="NewFolderField" Columns="25"></asp:TextBox>
                            <asp:ImageButton ID="btnNewFolder" runat="server" ImageUrl="images/buttons/go.png"></asp:ImageButton>

                            <br />
                            Copy Image as:
                            <br />
                            <asp:TextBox ID="FileCopyField" Columns="25" runat="server"></asp:TextBox>
                            <asp:ImageButton ID="btnFileCopy" runat="server" ImageUrl="images/buttons/Go.png"></asp:ImageButton>

                            <br />
                            Rename Image to:
                            <br />
                            <asp:TextBox ID="FileRenameField" Columns="25" runat="server"></asp:TextBox>
                            <asp:ImageButton ID="btnFileRename" runat="server" ImageUrl="images/buttons/Go.png"></asp:ImageButton>
                        </div>
                    </div>
                </td>

                <td style="width:250px;">
                    <h2>Selected image</h2>
                    <table border="0" cellspacing="0" cellpadding="0" width="250" class="imageInfo">
                        <tr>
                            <td valign="top" align="left">
                                <div class="image">
                                    <asp:Image ID="imgPreview" runat="server" ImageUrl="~/images/System/NoImageAvailable.gif"></asp:Image>
                                </div>

                                <div class="details">
                                    <asp:Label ID="lblImageInfo" runat="server"></asp:Label><br /><br />
                                
                                    <a href="javascript:opener.closePopup();" runat="server" id="lnkChoose">
                                        <asp:Image runat="Server" ID="imgChooseThis" ImageUrl="~/BVAdmin/images/buttons/ChooseThisImage.png" />
                                    </a>
                                
                                    <asp:ImageButton ImageUrl="~/BVAdmin/images/buttons/delete.png" ID="btnDelete" runat="server"
                                    AlternateText="Delete Image" OnClientClick="return window.confirm('Delete this image?');"></asp:ImageButton>
                                </div>
                                
                            </td>
                        </tr>
            
                    </table>
                    <!--
                    <a href="javascript:opener.closePopup();">
                        <asp:Image ImageUrl="~/BVAdmin/images/buttons/cancel.png" runat="server" ID="imgCancel" />
                    </a>
                    -->
                </td>
            </tr>
        </table>
    </div>


    <asp:HiddenField runat="server" ID="SelectedFileField" />
</asp:Content>
