# A plugin may raise an ImportError. In this case, the plugin will be silently
# discarded.  Any other exception that happens during plugin loading will lead
# to a program abort.


# If pluginType is MODULE, the plugin loader will call moduleInformation.  The
# variable MODULE is inserted into the local namespace by the plugin loader.
pluginType = MODULE


# moduleInformation() must return a tuple (module, widget_list).  If "module"
# is "A" and any widget from this module is used, the code generator will write
# "import A".  If "module" is "A[.B].C", the code generator will write
# "from A[.B] import C".  Each entry in "widget_list" must be unique.
def moduleInformation():
    return "PyQt4.Qwt5", ("Qwt5.QwtAnalogClock",
                          "Qwt5.QwtCompass",
                          "Qwt5.QwtCounter",
                          "Qwt5.QwtDial",
                          "Qwt5.QwtKnob",
                          "Qwt5.QwtPlot",
                          "Qwt5.QwtScaleWidget",
                          "Qwt5.QwtSlider",
                          "Qwt5.QwtThermo",
                          "Qwt5.QwtWheel",
                          "Qwt5.QwtTextLabel",)
