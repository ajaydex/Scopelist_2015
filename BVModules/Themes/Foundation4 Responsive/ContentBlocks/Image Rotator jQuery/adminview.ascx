<%@ Control Language="VB" AutoEventWireup="false" CodeFile="adminview.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_ContentBlocks_Image_Rotator_jQuery_adminview" %>

<div class="block imageRotatorJQuery">
    <h6>Image Rotator - jQuery</h6>

    <div class="alert-box alert">This content block is not compatible with the "Responsive" theme.</div>

    <div class="alert-box secondary">
        <p>The Responsive theme is built on Foundation 4. If you want to implement a jQuery image rotator use Orbit instead. It's built into Foundation 4. All you have to do us add the following to an HTML Content Block. <a href="http://foundation.zurb.com/docs/v/4.3.2/components/orbit.html">Learn More</a></p>

        <code>
        &lt;div class=&quot;slideshow-wrapper&quot;&gt;<br />
        &lt;div class=&quot;preloader&quot;&gt;&amp;nbsp;&lt;/div&gt;<br />
        &lt;ul data-orbit=&quot;&quot; data-options=&quot;container_class:orbit-container billboard;slide_number:false; stack_on_small:true; &quot;&gt;<br />
        &lt;li&gt;&lt;img src=&quot;/images/slider/slide1.jpg&quot; alt=&quot;&quot; /&gt;&lt;/li&gt;<br />
        &lt;li&gt;&lt;img src=&quot;/images/slider/slide2.jpg&quot; alt=&quot;&quot; /&gt;&lt;/li&gt;<br />
        &lt;li&gt;&lt;img src=&quot;/images/slider/slide3.jpg&quot; alt=&quot;&quot; /&gt;&lt;/li&gt;<br />
        &lt;li&gt;&lt;img src=&quot;/images/slider/slide4.jpg&quot; alt=&quot;&quot; /&gt;&lt;/li&gt;<br />
        &lt;/ul&gt;<br />
        &lt;/div&gt;
        </code>
    </div>

    <asp:Literal EnableViewState="false" ID="PreHtml" runat="server"></asp:Literal>
    <asp:Literal ID="litMain" runat="server" EnableViewState="false"></asp:Literal>
    <asp:Literal EnableViewState="false" ID="PostHtml" runat="server"></asp:Literal>  
</div>