--- a/dmenu.1	2022-10-04 10:36:58.000000000 -0700
+++ b/dmenu.1	2024-03-23 19:40:27.116453289 -0700
@@ -8,6 +8,12 @@
 .IR lines ]
 .RB [ \-m
 .IR monitor ]
+.RB [ \-x
+.IR xoffset ]
+.RB [ \-y
+.IR yoffset ]
+.RB [ \-z
+.IR width ]
 .RB [ \-p
 .IR prompt ]
 .RB [ \-fn
@@ -54,6 +60,24 @@
 dmenu is displayed on the monitor number supplied. Monitor numbers are starting
 from 0.
 .TP
+.BI \-x " xoffset"
+dmenu is placed at this offset measured from the left side of the monitor.
+Can be negative.
+If option
+.B \-m
+is present, the measurement will use the given monitor.
+.TP
+.BI \-y " yoffset"
+dmenu is placed at this offset measured from the top of the monitor.  If the
+.B \-b
+option is used, the offset is measured from the bottom.  Can be negative.
+If option
+.B \-m
+is present, the measurement will use the given monitor.
+.TP
+.BI \-z " width"
+sets the width of the dmenu window.
+.TP
 .BI \-p " prompt"
 defines the prompt to be displayed to the left of the input field.
 .TP
--- a/dmenu.c	2022-10-04 10:36:58.000000000 -0700
+++ b/dmenu.c	2024-03-23 19:39:53.173081139 -0700
@@ -37,6 +37,9 @@
 static char text[BUFSIZ] = "";
 static char *embed;
 static int bh, mw, mh;
+static int dmx = 0; /* put dmenu at this x offset */
+static int dmy = 0; /* put dmenu at this y offset (measured from the bottom if topbar is 0) */
+static unsigned int dmw = 0; /* make dmenu this wide */
 static int inputw = 0, promptw;
 static int lrpad; /* sum of left and right padding */
 static size_t cursor;
@@ -658,9 +661,9 @@
 				if (INTERSECT(x, y, 1, 1, info[i]) != 0)
 					break;
 
-		x = info[i].x_org;
-		y = info[i].y_org + (topbar ? 0 : info[i].height - mh);
-		mw = info[i].width;
+		x = info[i].x_org + dmx;
+		y = info[i].y_org + (topbar ? dmy : info[i].height - mh - dmy);
+		mw = (dmw>0 ? dmw : info[i].width);;
 		XFree(info);
 	} else
 #endif
@@ -668,9 +671,9 @@
 		if (!XGetWindowAttributes(dpy, parentwin, &wa))
 			die("could not get embedding window attributes: 0x%lx",
 			    parentwin);
-		x = 0;
-		y = topbar ? 0 : wa.height - mh;
-		mw = wa.width;
+		x = dmx;
+		y = topbar ? dmy : wa.height - mh - dmy;
+		mw = (dmw>0 ? dmw : wa.width);
 	}
 	promptw = (prompt && *prompt) ? TEXTW(prompt) - lrpad / 4 : 0;
 	inputw = mw / 3; /* input width: ~33% of monitor width */
@@ -711,6 +714,7 @@
 usage(void)
 {
 	die("usage: dmenu [-bfiv] [-l lines] [-p prompt] [-fn font] [-m monitor]\n"
+	      "             [-x xoffset] [-y yoffset] [-z width]\n"
 	    "             [-nb color] [-nf color] [-sb color] [-sf color] [-w windowid]");
 }
 
@@ -737,6 +741,12 @@
 		/* these options take one argument */
 		else if (!strcmp(argv[i], "-l"))   /* number of lines in vertical list */
 			lines = atoi(argv[++i]);
+		else if (!strcmp(argv[i], "-x"))   /* window x offset */
+			dmx = atoi(argv[++i]);
+		else if (!strcmp(argv[i], "-y"))   /* window y offset (from bottom up if -b) */
+			dmy = atoi(argv[++i]);
+		else if (!strcmp(argv[i], "-z"))   /* make dmenu this wide */
+			dmw = atoi(argv[++i]);
 		else if (!strcmp(argv[i], "-m"))
 			mon = atoi(argv[++i]);
 		else if (!strcmp(argv[i], "-p"))   /* adds prompt to left of input field */
