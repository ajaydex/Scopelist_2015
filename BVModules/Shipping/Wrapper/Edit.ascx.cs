// Copyright Structured Solutions
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using BVSoftware.Bvc5.Core.Content;
using BVSoftware.Bvc5.Core.Shipping;
using StructuredSolutions.Bvc5.Shipping.Providers;
using StructuredSolutions.Bvc5.Shipping.Providers.Controls;
using ASPNET = System.Web.UI.WebControls;

public partial class BVModules_Shipping_Wrapper_Edit : WrapperEditor
{
    #region Overrides

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        LoadData();
    }

    #endregion

    #region Event Handlers

    private void _baseProviderModule_EditingComplete(object sender, BVModuleEventArgs e)
    {
        if (String.Compare(e.Info, "Canceled", true) != 0)
        {
            if (Page.IsValid)
            {
                SaveData();
            }
        }
        NotifyFinishedEditing(e.Info);
    }

    protected void BaseProviderField_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            SaveData();
            // Redirect so that IsPostBack = false in the base provider module
            Response.Redirect(Request.Url.ToString());
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) DataBind();
    }

    protected void Unwrap_Click(object sender, EventArgs e)
    {
        ShippingMethod method = BaseProviderModule.ShippingMethod;
        method.ShippingProviderId = Settings.ShippingProviderId;
        ShippingMethod.Update(method);
        // Redirect so that IsPostBack = false in the base provider module
        Response.Redirect(Request.Url.ToString());
    }

    #endregion

    #region Properties

    private BVShippingModule _baseProviderModule = null;

    protected BVShippingModule BaseProviderModule
    {
        get
        {
            if (_baseProviderModule == null)
                LoadBaseProviderModule();
            return _baseProviderModule;
        }
    }

    protected ExtendedShippingProvider Provider
    {
        get
        {
            ShippingProvider provider = AvailableProviders.FindProviderById(ShippingMethod.ShippingProviderId);
            return provider as ExtendedShippingProvider;
        }
    }

    #endregion

    #region Methods

    private static ListItem[] GetProviders()
    {
        List<ListItem> providers = new List<ListItem>();
        foreach (ShippingProvider provider in AvailableProviders.Providers)
        {
            if (!(provider is ExtendedShippingProvider))
            {
                providers.Add(new ListItem(provider.Name, provider.ProviderId));
            }
        }
        return providers.ToArray();
    }

    private void LoadBaseProviderModule()
    {
        BaseProviderModuleHolder.Controls.Clear();
        String providerName = BaseProviderField.SelectedItem.Text;
        _baseProviderModule = ModuleController.LoadShippingEditor(providerName, Page) as BVShippingModule;
        if (_baseProviderModule != null)
        {
            _baseProviderModule.EditingComplete += _baseProviderModule_EditingComplete;
            _baseProviderModule.BlockId = BlockId;
            _baseProviderModule.ShippingMethod = ShippingMethod;
            BaseProviderModuleHolder.Controls.Add(_baseProviderModule);
        }
        else
        {
            BaseProviderModuleHolder.Controls.Add(new LiteralControl("Can not load the editor for " + providerName));
        }
    }

    private void LoadData()
    {
        BaseProviderField.Items.Clear();
        BaseProviderField.Items.AddRange(GetProviders());
        if (BaseProviderField.Items.FindByValue(Settings.ShippingProviderId) == null)
            Settings.ShippingProviderId = BaseProviderField.Items[0].Value;
        BaseProviderField.SelectedValue = Settings.ShippingProviderId;
        LoadBaseProviderModule();
        ShipMethodVisibleField.Checked = Settings.Visible;
    }

    private void SaveData()
    {
        Settings.Visible = ShipMethodVisibleField.Checked;
        Settings.ShippingProviderId = BaseProviderField.SelectedValue;
        ShippingMethod.Update(ShippingMethod);
    }

    #endregion
}