function qu() {
    }
    qu = Backbone.View.extend({rr: 250,Id: 7,Bq: $("#currentSlideArrow").height(),$q: 300,ar: 15,hr: 500,cm: 1E3,Pl: 215,initialize: function() {
            this.Sj = {};
            this.vh = g;
            this.ob = this.selectedIndex = 0;
            this.hk = g;
            this.Ze = h;
            this.kh = {};
            this.model.bind("change:currentTrack", r(this, this.Qf));
            z.c(Se, r(this, this.gn));
            this.model.bind("change:keyPressed", r(this, this.Dv));
            this.model.bind("change:currentContextualTip", r(this, this.Tu));
            z.c(zd, r(this, this.Ms));
            z.c(Vd, r(this, this.ye));
            z.c(he, r(this, this.QA));
            z.c(je, r(this, this.wA));
            z.c(dg, r(this, this.TA));
            z.c($e, r(this, this.Kx));
            z.c(bg, r(this, this.Yp));
            z.c(lg, r(this, this.Og));
            z.c(Uh, r(this, this.Si));
            z.c(Ud, r(this, this.Ly));
            z.c(Df, r(this, this.To));
            z.c(Ef, r(this, this.To));
            z.c(eg, r(this, this.bo));
            z.c(bf, r(this, this.bo));
            z.c(Zh, r(this, this.Tc));
            z.c(Yh, r(this, this.Sc));
            U(Dr, r(this, this.GA));
            U(Hr, r(this, this.gw));
            U(Er, r(this, this.ho));
            U(Fr, r(this, this.fo));
            U(xq, r(this, this.bk));
            U(Pr, r(this, this.yl));
            $("#track_menu_dd .newStationFromSong").click(r(this, this.gk));
            $("#track_menu_dd .newStationFromArtist").click(r(this,
            this.fk));
            $("#track_menu_dd .tiredOfSong").click(r(this, this.ul));
            $("#track_menu_dd .whySelected").click(r(this, this.yB));
            $("#track_menu_dd .moveSong").click(r(this, this.ak));
            bu.push("/song/sleep/");
            this.Yw();
            this.Og(mj())
        },el: $(".slidesForeground").get(0),Yw: function() {
            this.Co = this.r = xj();
            this.gd = g;
            this.Pj = this.r;
            this.yl();
            $("#trackInfo .slideDragHandle").draggable({axis: "y",containment: $(".slideDragLimit"),helper: "clone",start: r(this, this.Bi),stop: r(this, this.Ci),drag: r(this, this.Ai)});
            $("#trackInfo .slideDragHandle").hover(function() {
                $("#trackInfo .slideDrag").addClass("hover")
            },
            function() {
                $("#trackInfo .slideDrag").removeClass("hover")
            })
        },Bi: function(b, c) {
            T(Cr);
            this.An = c.offset.top - this.r;
            this.zp();
            w("link", {click: "resizeAlbumArt",source: "AlbumSlidesView"}, this.model.get("currentUser"))
        },zp: function() {
            this.gd != g && clearTimeout(this.gd);
            this.gd = setTimeout(r(this, function() {
                if (this.r != this.Pj)
                    this.r = this.Pj, this.Yc();
                this.zp()
            }), 1E3 / 60)
        },Ci: function(b, c) {
            this.gd != g && clearTimeout(this.gd);
            this.gd = g;
            this.r = c.offset.top - this.An;
            this.yl();
            B(Mi, this.r)
        },Ai: function(b, c) {
            this.Pj =
            c.offset.top - this.An
        },Tc: function(b) {
            this.Co = this.r;
            if (b && "ANIMATEDOVERLAY" == b.t()) {
                if (this.r != this.Pl)
                    this.r = this.Pl, this.Yc();
                $(".slides", this.el).fadeOut(200)
            }
        },Sc: function(b) {
            if (b && "ANIMATEDOVERLAY" == b.t())
                this.r = this.Co, this.Yc(), $(".slides", this.el).fadeIn(200)
        },yl: function() {
            this.Fm();
            this.Im($(".stationSlides", this.el))
        },Yc: function() {
            this.Fm();
            var b = this.model.get("currentStation");
            b != g && this.Im($("#stationSlides" + b.e()))
        },Fm: function() {
            $(".slides", this.el).height(this.r);
            var b = this.r + this.Id;
            $("#mainContentContainer .slidesBackground div").height(b);
            $(".slides", this.el).css("margin-top", -(b + this.Bq + 1));
            $("#currentSlideArrow").css("margin-right", Math.floor(this.r / 2) - this.Id)
        },Im: function(b) {
            b.each(r(this, function(b, d) {
                $("img", d).attr({width: this.r,height: this.r});
                $(".slide", d).css({width: this.r,height: this.r});
                var f = 0.8 * this.r;
                $(".pauseWatermark", d).css({width: f,height: 0.3 * this.r,right: this.r + Math.floor((this.r - f) / 2) + 2 * this.Id});
                $(".muteWatermark", d).css({width: f,height: 0.3 * this.r,right: this.r +
                    Math.floor((this.r - f) / 2) + 2 * this.Id});
                $(".replayWatermark", d).css({width: f,height: 0.3 * this.r,right: this.r + Math.floor((this.r - f) / 2) + 2 * this.Id});
                this.Ye($(d))
            }))
        },ib: function() {
            var b = this.model.get("currentStation");
            return b != g ? $("#stationSlides" + b.e()) : g
        },Qf: function() {
            if (this.Ze)
                gd(this, this.Qf, 100);
            else {
                this.mi();
                var b = this.model.get("currentTrack"), c = this.model.get("currentStation");
                if (c != g && b != g) {
                    var c = c.e(), d = this.Sj[c];
                    if (d == g || d != b.j()) {
                        var d = $("#stationSlides" + c), f = $(".slide", d).eq(1), k = $(".slide",
                        d).eq(0);
                        this.kh[c] == g && (this.kh[c] = 0);
                        k.data("track", b);
                        k.data("slideIndex", this.kh[c]++);
                        var n = $("#songSlideTmpl").tmpl(this.r);
                        d.prepend(n);
                        this.Bz(f);
                        $(".pauseWatermark", f).fadeOut();
                        $(".muteWatermark", f).fadeOut();
                        this.paused = h;
                        this.muted && this.cl();
                        var s = $(".art", k).attr("src", b.Pa());
                        s && s.bind("imgpreload", function() {
                            $(this).fadeIn("fast").prev().hide()
                        });
                        $(".treatment.current", k).stop(e, e).fadeIn(400, function() {
                            $(this).show()
                        });
                        $(".treatment.previous", k).stop(e, e).fadeOut(400, function() {
                            $(this).hide()
                        });
                        0 < f.length && ($(".treatment.current", f).stop(e, e).fadeOut(400, function() {
                            $(this).hide()
                        }), f.data("track") instanceof Oj || this.Ti(f, 400));
                        0 == this.selectedIndex ? (n.animate({width: this.r}), this.Te(b)) : (this.selectedIndex++, n.css({width: this.r}));
                        this.Sj[c] = b.j();
                        this.Ye(d);
                        this.iq(k, b)
                    }
                }
                this.jf();
                0 == this.selectedIndex ? this.Te(b) : (b.da() && this.bk(), this.mn(), this.hk = setTimeout(r(this, function() {
                    this.bk()
                }), 1E3 * this.ar))
            }
        },Bz: function(b) {
            if (b.data("track") instanceof Oj) {
                var c = this.model.get("currentStation");
                if (c && !c.ka())
                    this.model.get("displayingCompanion") ? (this.Si(), this.sd = b) : (this.sd = b, this.Si())
            }
        },Si: function() {
            var b = this.model.get("currentStation");
            if (this.sd && !b.ka()) {
                var c = this.sd.data("track");
                if (c != g) {
                    c.zc = "";
                    c.$a = "/img/ads/generictile.png";
                    var d = $(".art", this.sd);
                    this.Ti(this.sd, 200, function() {
                        d.attr("src", c.Pa())
                    })
                }
                this.sd = g
            }
        },Te: function(b) {
            var c = this.model.get("selectedTrack");
            (c == g || b == g || c.j() != b.j()) && this.model.set({selectedTrack: b})
        },mn: function() {
            this.hk != g && clearTimeout(this.hk)
        },
        gn: function() {
            this.mi();
            var b = g, c = this.model.get("currentStation");
            c != g && (b = c.e());
            if (b != this.H)
                this.selectedIndex = 0, this.ht(b), this.H != g ? (this.uA(this.H, r(this, function() {
                    this.H = g;
                    this.gn()
                })), this.Qw(), T(ir)) : (this.H = b, this.tA(b), this.jf())
        },Ms: function() {
            $(".stationSlides", this.el).remove();
            this.H = g;
            this.Sj = {};
            this.kh = {};
            this.r = xj()
        },ye: function(b) {
            var c = b.track, d = this;
            $("#stationSlides" + b.stationId).find(".slide").each(function() {
                d.iq(this, c)
            })
        },iq: function(b, c) {
            var d = $(b).data("track");
            lt(d,
            this.model.get("stationList")) == p.Ba.sb() ? ($(".thumbUp", b).addClass("thumbUpDis").empty(), $(".thumbDown", b).addClass("thumbDownDis").empty()) : d && d.j() == c.j() && ($(".thumbUp", b).removeClass("indicator"), $(".thumbDown", b).removeClass("indicator"), 1 == c.Nb ? $(".thumbUp", b).addClass("indicator") : -1 == c.Nb && $(".thumbDown", b).addClass("indicator"), $(b).data("track", c))
        },uA: function(b, c) {
            if (b != g) {
                this.Ze = e;
                var d = $("#stationSlides" + b);
                if (0 < d.length) {
                    var f = d.width(), k = f - (this.On() + this.Qn(d));
                    d.animate({width: k},
                    r(this, function() {
                        d.hide();
                        d.width(f);
                        this.Ye(d);
                        this.Ze = h;
                        c()
                    }));
                    return
                }
            }
            c()
        },tA: function(b) {
            if (b != g) {
                this.Ze = e;
                $(".stationSlides", this.el).hide();
                var c = $("#stationSlides" + b);
                this.Ye(c);
                var d = this.kg(c), f = this.r * (d + 3);
                c.css("left", f);
                c.show();
                c.animate({left: -f}, r(this, function() {
                    gd(this, function() {
                        var c = this.model.get("currentStation");
                        c && c.e() == b && 0 < d && this.model.get("selectedTrack") == g && this.Te(this.model.get("currentTrack"))
                    }, 500);
                    this.Yc();
                    this.Ze = h
                }))
            }
        },ht: function(b) {
            if (b != g) {
                var c = $("#stationSlides" +
                b);
                if (0 == c.length) {
                    var c = $("#stationSlidesTmpl").tmpl().appendTo($(".slides", this.el)), d = $("#songSlideTmpl").tmpl(this.r);
                    d.width(this.r);
                    c.append(d);
                    this.Ye(c);
                    c.attr("id", "stationSlides" + b);
                    c.show()
                }
            }
        },Ye: function(b) {
            var c = "none" != b.css("display"), d = this.kg(b);
            b.width(this.On() + this.r * (d + 4));
            c = this.r * (d + 3) * (c ? -1 : 1);
            d = this.Rn(b);
            b.css({left: c,"padding-left": d})
        },On: function() {
            return $("#mainContentContainer").width() - $(".stationContent").outerWidth()
        },Dv: function() {
            var b = this.model.get("keyPressed");
            if (b != g && "INPUT" != b.target.tagName && "TEXTAREA" != b.target.tagName && $("#mainContent .home").is(":visible")) {
                if (37 == b.which) {
                    this.zg(1);
                    return
                }
                if (39 == b.which) {
                    this.zg(-1);
                    return
                }
            }
            this.fj()
        },zg: function(b) {
            if (!this.ck)
                this.ob = b, this.$j = 0, this.zi()
        },moveTo: function(b) {
            this.$j = this.ob = 0;
            this.Bp(b)
        },bk: function() {
            this.moveTo(0)
        },zi: function() {
            if (!this.ck)
                if (0 != this.ob)
                    this.Bp(this.selectedIndex + this.ob);
                else {
                    var b = this.ib(), c = $(".slide", b).eq(this.selectedIndex + 1);
                    if (c)
                        $(".treatment.previous", c).stop(e,
                        e).fadeOut(200, function() {
                            $(this).hide()
                        }), this.ek != g && clearTimeout(this.ek), this.ek = setTimeout(r(this, function() {
                            this.ek = g;
                            this.Te(c.data("track"))
                        }), this.hr);
                    this.jf()
                }
        },fj: function() {
            if (0 != this.ob)
                this.ob = 0, this.zi()
        },Bp: function(b) {
            var c = this.ib();
            if (c)
                if (b = Math.max(b, 0), b = Math.min(b, this.kg(c) - 1), b != this.selectedIndex) {
                    var d = $(".slide", c).eq(this.selectedIndex + 1);
                    if (d) {
                        var f = this.model.get("currentStation"), k = d.data("track"), f = f.ka();
                        (!f || f && !(k instanceof Oj)) && this.Ti(d, 200)
                    }
                    this.Te(g);
                    this.mn();
                    this.selectedIndex = b;
                    b = 0 == this.$j ? "easeInQuad" : "linear";
                    this.ck = e;
                    c.animate({"padding-left": this.Rn(c)}, this.$q, b, r(this, function() {
                        this.ck = h;
                        0 > this.ob ? this.ob-- : 0 < this.ob && this.ob++;
                        this.$j++;
                        this.zi()
                    }))
                } else
                    this.fj()
        },Ti: function(b, c, d) {
            sd() ? $(".treatment.previous", b).stop(e, e).animate({opacity: 0.75}, c, function() {
                $(this).show();
                d && d()
            }) : $(".treatment.previous", b).stop(e, e).fadeIn(c, function() {
                $(this).show();
                d && d()
            })
        },kg: function(b) {
            return b != g ? $(".slide", b).length - 1 : 0
        },Rn: function(b) {
            return Math.max(0,
            this.Qn(b) * this.selectedIndex)
        },Qn: function(b) {
            return $(".slide", b).last().outerWidth(e)
        },gk: function() {
            if (this.Dc) {
                var b = this.Dc.data("track");
                b && z.b(Bg, "mi" + b.j())
            }
            return h
        },fk: function() {
            if (this.Dc) {
                var b = this.Dc.data("track");
                b && z.b(Bg, "mi" + b.$c)
            }
            return h
        },ul: function() {
            var b = this.Dc.data("track");
            b && z.b(Sg, b);
            return h
        },QA: function(b) {
            var c = this.model.get("currentTrack");
            if (b != g && b.j() == c.j())
                this.ll = e, z.b(eg), b = "/song/sleep/" + b.j(), $t(b), au(b)
        },Ly: function() {
            if (this.ll)
                (new X({message: Fb()})).render(),
                this.ll = h
        },To: function() {
            this.ll = h
        },yB: function() {
            var b = this.Dc.data("track");
            if (b) {
                var c = e, d = this.model.get("currentStation");
                if (d && (d.o() && !d.G() || d.Fa()))
                    c = h;
                z.b(Tg, {track: b,allowActions: c})
            }
            return h
        },ak: function() {
            var b = this.Dc.data("track");
            new ru({model: this.model,track: b});
            return h
        },wA: function(b) {
            this.model.get("currentTrack");
            var c = b[2];
            if (b = this.ib()) {
                var d = this;
                $(".slide", b).each(function() {
                    var b = $(this).data("track");
                    if (b && b.j() == c.j())
                        return $(this).data("disableMenu", e), d.Fj($(this)),
                        h
                })
            }
        },Og: function(b) {
            0 == b ? (this.muted = e, this.cl()) : (this.muted = h, this.Ae())
        },Ae: function() {
            var b = this.ib(), b = $(".slide", b).eq(1);
            $(".muteWatermark", b).fadeOut()
        },cl: function() {
            if (!this.paused) {
                var b = this.ib(), b = $(".slide", b).eq(1);
                $(".muteWatermark", b).css("visibility", "visible").fadeIn();
                this.Yc()
            }
        },bo: function() {
            this.Lk && this.Yp()
        },Yp: function() {
            this.Dj();
            this.wg()
        },Dj: function() {
            this.paused = h;
            var b = this.ib(), b = $(".slide", b).eq(1);
            $(".pauseWatermark", b).fadeOut();
            this.muted && this.cl()
        },gA: function() {
            this.paused =
            e;
            if (!this.Lk) {
                this.Ae();
                this.wg();
                var b = this.ib(), b = $(".slide", b).eq(1);
                $(".pauseWatermark", b).css("visibility", "visible").fadeIn();
                this.Yc()
            }
        },TA: function() {
            this.gA()
        },Kx: function() {
            this.kA()
        },kA: function() {
            this.Ae();
            this.Dj();
            this.Lk = e;
            var b = this.ib(), b = $(".slide", b).eq(1);
            $(".replayWatermark", b).css("visibility", "visible").fadeIn();
            this.Yc()
        },wg: function() {
            this.Lk = h;
            var b = this.ib(), b = $(".slide", b).eq(1);
            $(".replayWatermark", b).fadeOut()
        },Qw: function() {
            this.Dj();
            this.Ae();
            this.wg()
        },GA: function(b) {
            b &&
            b.md() && b.I() && b.md().j() && z.b(Ug, [b.md().e(), b.I().e(), b.md().j(), b.mt.e()])
        },fo: function() {
            var b = $(".slide", this.el);
            1 == b.length ? this.$k($(b[0]), e) : 1 < b.length && this.$k($(b[1]), e)
        },Tu: function() {
            this.model.get("currentContextualTip") || $(".submenu").removeClass("submenu_force_visible")
        },gw: function() {
            this.ho();
            setTimeout(r(this, function() {
                $(".submenu").addClass("submenu_force_visible")
            }), 100)
        },ho: function() {
            this.fo();
            this.V.open()
        },jf: function() {
            if (this.Wm) {
                var b = $(".slides", this.el).height(), c = $(".slides_right_scroll",
                this.el).height(), b = Math.floor(b / 2) + c;
                $(".slides_right_scroll", this.el).css("margin-top", -1 * b);
                $(".slides_left_scroll", this.el).css("margin-top", -1 * b);
                0 < this.selectedIndex ? $(".slides_right_scroll", this.el).stop(e, e).fadeIn(200) : $(".slides_right_scroll", this.el).stop(e, e).fadeOut(200);
                this.selectedIndex < this.kg(this.ib()) - 1 ? $(".slides_left_scroll", this.el).stop(e, e).fadeIn(200) : $(".slides_left_scroll", this.el).stop(e, e).fadeOut(200)
            } else
                $(".slides_right_scroll", this.el).stop(e, e).delay(this.cm).fadeOut(200),
                $(".slides_left_scroll", this.el).stop(e, e).delay(this.cm).fadeOut(200)
        },events: {mouseover: "allSlidesMouseEnter",mouseout: "allSlidesMouseLeave","mousedown .slides_right_scroll": "rightScrollDown","mouseup .slides_right_scroll": "scrollMouseUp","mousedown .slides_left_scroll": "leftScrollDown","mouseup .slides_left_scroll": "scrollMouseUp","mouseenter .slide": "slideMouseEnter","mouseleave .slide": "slideMouseLeave","click .slide": "slideClick","click .thumbDown": "thumbDownClick","click .thumbUp": "thumbUpClick",
            "click .pauseWatermark": "pauseWatermarkClick","click .replayWatermark": "replayWatermarkClick","click .muteWatermark": "muteWatermarkClick"},pauseWatermarkClick: function() {
            z.b(bg, {userInitiated: e});
            return h
        },replayWatermarkClick: function() {
            this.wg();
            var b = this.model.get("currentStation");
            b && z.b(bf, b.e());
            return h
        },muteWatermarkClick: function() {
            this.Ae();
            T(ir);
            T(cs);
            return h
        },allSlidesMouseEnter: function() {
            this.Wm = e;
            this.jf()
        },allSlidesMouseLeave: function(b) {
            if (!(b.relatedTarget && 0 < $(b.relatedTarget).parents(".slidesForeground").length))
                this.Wm =
                h, this.jf()
        },rightScrollDown: function() {
            T(fs);
            this.zg(-1);
            return h
        },leftScrollDown: function() {
            T(fs);
            this.zg(1);
            return h
        },scrollMouseUp: function() {
            this.fj();
            return h
        },slideMouseEnter: function(b) {
            if (!$("#track_menu_dd").is(":visible") || !this.V || this.V.Pf())
                b = $(b.target).closest(".slide"), 0 == jt(this.model).length ? $("#track_menu_dd .moveSong").hide() : $("#track_menu_dd .moveSong").show(), this.$k(b, h), $(".previous", b).stop(e, e).animate({opacity: 0.5}, 200)
        },$k: function(b, c) {
            var d = b.data("track");
            if (!(d &&
            (d instanceof Oj || d.kc) || b.data("disableMenu"))) {
                if (this.fe != g && b != g) {
                    var d = this.fe.data("track"), f = b.data("track");
                    d && f && d.j() == f.j() && this.V.unbind("close")
                }
                this.mi();
                this.ki();
                var k = b.find(".thumbContainer"), d = r(this, function() {
                    k.fadeIn(200);
                    this.ki();
                    this.qs(k)
                });
                c ? d() : this.vh = setTimeout(d, this.rr)
            }
        },mi: function() {
            this.V != g && su != g && this.V.close()
        },qs: function(b) {
            this.V == g ? this.V = new tu(this.model, b) : uu(this.V, $(".menuArrow", b));
            this.Dc = b.closest(".slide");
            var c = this.model.get("currentStation");
            c && (c.o() && !c.G() || c.Fa()) ? ($("#track_menu_dd .moveSong").hide(), $("#track_menu_dd .tiredOfSong").hide()) : ($("#track_menu_dd .moveSong").show(), $("#track_menu_dd .tiredOfSong").show());
            var d = b.offset(), c = d ? d.top : 0, d = d ? d.left : 0;
            $("#track_menu_dd").css({top: c - $("#track_menu_dd").height(),left: d - $("#track_menu_dd").width() / 2 + b.width() / 2})
        },slideMouseLeave: function(b) {
            b = $(b.target).closest(".slide");
            this.V && su != g ? (this.fe = b, this.V.bind("close", r(this, this.Fj))) : this.Fj(b);
            $(".previous", b).stop(e, e).animate({opacity: sd() ?
                0.75 : 1}, 200)
        },slideClick: function(b) {
            var c = h, d = $(b.target).closest(".slide"), f = $(b.target).closest(".stationSlides"), b = d.data("track"), d = d.data("slideIndex");
            b && 0 <= d && (d = $(".slide", f).length - d - 2, b instanceof Oj && (c = e, b.zc && window.open(b.zc)), b && this.moveTo(d));
            c || T(fs)
        },Fj: function(b) {
            if (!b && this.fe)
                b = this.fe, this.fe = g;
            b && (b.find(".thumbContainer").fadeOut(200), this.ki())
        },ki: function() {
            if (this.vh != g)
                clearTimeout(this.vh), this.vh = g
        },thumbDownClick: function(b) {
            $(b.target).blur();
            var b = $(b.target).closest(".slide").data("track"),
            c = lt(b, this.model.get("stationList"));
            b != g && c != p.Ba.sb() && (T(er, {isPositive: h,musicId: b.j()}), w("thumb_click", {is_positive: "false",source: "AlbumSlidesView"}, this.model.get("currentUser")));
            return h
        },thumbUpClick: function(b) {
            $(b.target).blur();
            var b = $(b.target).closest(".slide").data("track"), c = lt(b, this.model.get("stationList"));
            b != g && c != p.Ba.sb() && (T(er, {isPositive: e,musicId: b.j()}), w("thumb_click", {is_positive: "true",source: "AlbumSlidesView"}, this.model.get("currentUser")));
            return h
        }});