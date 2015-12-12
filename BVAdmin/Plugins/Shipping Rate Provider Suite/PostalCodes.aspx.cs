using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Threading;
using System.Web.UI.WebControls;
using Anthem;
using BVSoftware.Bvc5.Core;
using BVSoftware.Bvc5.Core.Content;
using BVSoftware.Bvc5.Core.Metrics;
using StructuredSolutions.Bvc5.Shipping.PostalCodes;

public partial class BVAdmin_Plugins_Shipping_Rate_Provider_Suite_PostalCodes : BaseAdminPage
{
    #region Event Handlers

    protected void Countries_DataBound(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Countries.SelectedValue = WebAppSettings.SiteShippingAddress.CountryBvin;
        }
    }

    protected void InstallZipCodes_Click(object sender, EventArgs e)
    {
        try
        {
            ThreadPool.QueueUserWorkItem(LoadZipCodes);
            Manager.AddScriptForClientSideEval(
                "alert('US ZIP codes are being loaded. Please monitor the Audit Log for details.');");
        }
        catch (Exception ex)
        {
            Manager.AddScriptForClientSideEval(string.Format("alert('{0}');", ex.Message));
        }
    }

    protected void LoadPostalCodes_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            int codeIndex = Int32.Parse(CodeIndex.Text) - 1;
            int latitudeIndex = Int32.Parse(LatitudeIndex.Text) - 1;
            int longitudeIndex = Int32.Parse(LongitudeIndex.Text) - 1;
            int cityIndex = string.IsNullOrEmpty(CityIndex.Text) ? -1 : Int32.Parse(CityIndex.Text) - 1;
            int regionIndex = string.IsNullOrEmpty(RegionIndex.Text) ? -1 : Int32.Parse(RegionIndex.Text) - 1;

            try
            {
                object[] state = {
                                     Countries.SelectedValue, PostalCodeFile.FileContent, PostalCodeFile.FileName,
                                     codeIndex, latitudeIndex, longitudeIndex, cityIndex, regionIndex
                                 };
                ThreadPool.QueueUserWorkItem(LoadZipCodes, state);
                Manager.AddScriptForClientSideEval(
                    "alert('Your postal codes are being loaded. Please monitor the Event Log for details.');");
            }
            catch (Exception ex)
            {
                Manager.AddScriptForClientSideEval(string.Format("alert('{0}');", ex.Message));
            }

            PostalCodeSummary.DataBind();
        }
    }

    protected void Page_PreInit(object sender, EventArgs e)
    {
        this.PageTitle = "Shipping Rate Provider Suite";
        this.CurrentTab = AdminTabType.Plugins;
        ValidateCurrentUserHasPermission(BVSoftware.Bvc5.Core.Membership.SystemPermissions.SettingsEdit);
    }  

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void PostalCodeSummary_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string countryBvin = PostalCodeSummary.DataKeys[e.Row.RowIndex].Value.ToString();
            Literal countryName = e.Row.FindControl("CountryName") as Literal;
            if (!string.IsNullOrEmpty(countryBvin) && countryName != null)
            {
                countryName.Text = Country.FindByBvin(countryBvin).DisplayName;
            }
        }
    }

    #endregion

    #region Methods

    private static void LoadZipCodes(object state)
    {
        if (state == null)
        {
            try
            {
                Stream zipcodes = new MemoryStream(File.ReadAllBytes(System.Web.Hosting.HostingEnvironment.MapPath("~/BVModules/Shipping/ZipCodes.csv")));
                EventLog.LogEvent("Postal Code Support", "Starting to load ZIP codes...", EventLogSeverity.Information);
                int count =
                    PostalCode.LoadCVS(Country.FindByISOCode("US").Bvin, zipcodes, "ZipCodes.csv", 1, 0, 3, 2, 5);
                EventLog.LogEvent("Postal Code Support", string.Format("Finished loading {0} ZIP codes.", count),
                                  EventLogSeverity.Information);
            }
            catch (Exception ex)
            {
                EventLog.LogEvent("Postal Code Support", ex.Message, EventLogSeverity.Error);
            }
        }
        else
        {
            object[] args = (object[]) state;
            String countryBvin = (string) args[0];
            Stream stream = (Stream) args[1];
            String filename = (String) args[2];
            Int32 codeIndex = (Int32) args[3];
            Int32 latitudeIndex = (Int32) args[4];
            Int32 longitudeIndex = (Int32) args[5];
            Int32 cityIndex = (Int32) args[6];
            Int32 regionIndex = (Int32) args[7];
            try
            {
                EventLog.LogEvent("Postal Code Support", "Starting to load postal codes...",
                                  EventLogSeverity.Information);
                int count =
                    PostalCode.LoadCVS(countryBvin, stream, filename, codeIndex, latitudeIndex, longitudeIndex,
                                       cityIndex, regionIndex);
                EventLog.LogEvent("Postal Code Support",
                                  string.Format("Finished loading {0} postal codes from {1}.", count, filename),
                                  EventLogSeverity.Information);
            }
            catch (Exception ex)
            {
                EventLog.LogEvent("Postal Code Support", ex.Message, EventLogSeverity.Error);
            }
        }
    }

    #endregion
}