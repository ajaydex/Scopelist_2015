$(document).ready(function () {

    /*SHOW THE NAV*/
    $('.top-bar').css('display', 'block');

    /*ADD CLASSES TO MENU PLUS FOR FOUNDATION TOP BAR*/
    $('.activeChild').addClass('active');

    /*ADD SEPARATORS TO TOP BAR*/
    $('.top-bar .top-bar-section .left li').after('<li class="divider"></li>')

    /*MOVE NAV LIST OUT OF WRAPPING DIVS SO IT WORKS WITH FOUNDATION*/
    $('.top-bar ul.left').prependTo('.top-bar-section');

    /*ADD CLASSES FOR TOP BAR FLYOUTS */
    $('.top-bar ul ul').addClass('dropdown');
    $('.dropdown').parent('li').addClass('has-dropdown');

    /*BACK TO TOP LINK SLIDER*/
    if (jQuery('html').offset().top < 100) {
        jQuery("#to-top").hide();
    }
    jQuery(window).scroll(function () {
        if (jQuery(this).scrollTop() > 100) {
            jQuery("#to-top").fadeIn();
        } else {
            jQuery("#to-top").fadeOut();
        }
    });
    jQuery('.scroll-button').click(function () {
        jQuery('body,html').animate({
            scrollTop: '0px'
        }, 1000);
        return false;
    });

    //FOR FOUNDATION RESPONSIVE TABLES
    $('#AccountPages table').addClass("responsive");

    //ADD CLASS TO SIDEMENU CONTROL
    $('.sidemenu ul').addClass("side-nav");

    /*SET HEIGHTS - equal height columns*/
    var item = "";
    function setheighttotallest(item) {
        var maxHeight = -1;

        $(item).height('auto');

        $(item).each(function () {
            maxHeight = maxHeight > $(this).height() ? maxHeight : $(this).height();
        });

        $(item).each(function () {
            $(this).height(maxHeight);
        });
    }

    setheighttotallest('.categorygrid .record');
    setheighttotallest('.addressbook .address');

    $(window).resize(function () {
        setheighttotallest('.categorygrid .record');
    });

    //CUSTOM CONTENT COLUMN EDIT LINKS
    if ($('a.customButton').length != 0) {
        var container = $('a.customButton').not('.navwrapper a.customButton').parent();
        $(container).addClass('contentColumn');
    }

    if ($('a#showhidecustombuttons').length != 0) {
        var visible = false;
        $('a#showhidecustombuttons').on('click', function () {
            if (visible == false) {
                $(this).text('Hide Edit Links');
                $('a.customButton').not('.navwrapper a.customButton').css('display', 'block');
                visible = true;
            }
            else {
                $(this).text('Display Edit Links');
                $('a.customButton').not('.navwrapper a.customButton').css('display', 'none');
                visible = false;
            }
            return false;
        });
    }

    //GRID / LIST VIEW SWAPPER
    if ( $('.viewswrapper').length != 0 ) {

        //get cookie value
        var cookieValue = $.cookie("view");

        if (cookieValue != null) {

            //how are the products displaying currently?
            if ($('.SingleProductDisplayPanel').length != 0) {
                var currentGrid = 'SingleProductDisplayPanel';//grid
            }
            else {
                var currentGrid = 'WideSingleProductDisplayPanel';//list
            }

            if (currentGrid != cookieValue) {
                $('.' + currentGrid).attr('class', cookieValue);
            }
            if (cookieValue === "WideSingleProductDisplayPanel") {
                $('.productgrid .columns').css("width", "100%");

                //we need to update the active state of the icons
                $('.viewswrapper .active').removeClass('active');
                //set active state for list view icon
                $('a#ListView').addClass('active');
            }
            else {
                //we need to update the active state of the icons
                $('.viewswrapper .active').removeClass('active');
                //set active state for grid view icon
                $('a#GridView').addClass('active');
            }
        }
        
        /*Grid Clicked*/
        $('a#GridView').on('click', function () {

            var currentview = $(this);
            $('.viewswrapper .active').removeClass('active');
            $(currentview).addClass('active');

            $('.WideSingleProductDisplayPanel').attr('class', 'SingleProductDisplayPanel');
            $('.productgrid .columns').css("width", "");

            //set cookie
            $.cookie("view", "SingleProductDisplayPanel", { path: '/' } );

            return false;
        });

        /*List Clicked*/
        $('a#ListView').on('click', function () {

            var currentview = $(this);
            $('.viewswrapper .active').removeClass('active');
            $(currentview).addClass('active');

            $('.SingleProductDisplayPanel').attr('class', 'WideSingleProductDisplayPanel');
            $('.productgrid .columns').css("width", "100%");

            //set cookie
            $.cookie("view", "WideSingleProductDisplayPanel", { path: '/' } );

            return false;
        });
    }
});