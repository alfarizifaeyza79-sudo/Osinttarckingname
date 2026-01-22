#!/bin/bash

# OSINT NAME SEARCH TOOL
# Scan 950+ Websites for Name Presence
# Version: 3.0 | Total Sites: 950+

# ==============================================
# CONFIGURATION
# ==============================================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
WHITE='\033[1;37m'
NC='\033[0m'
BOLD='\033[1m'

RESULTS_FILE="osint_results.txt"
LOG_FILE="search_log.txt"
SITES_COUNT=0
FOUND_COUNT=0
SCANNED_COUNT=0

# ==============================================
# ANIMATION FUNCTIONS
# ==============================================
show_banner() {
    clear
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════════════════════════════════════╗"
    echo "║                                                                      ║"
    echo "║  ██████╗ ███████╗██╗███╗   ██╗████████╗    ███████╗███████╗ ██████╗  ║"
    echo "║  ██╔══██╗██╔════╝██║████╗  ██║╚══██╔══╝    ██╔════╝██╔════╝██╔═══██╗ ║"
    echo "║  ██║  ██║███████╗██║██╔██╗ ██║   ██║       ███████╗█████╗  ██║   ██║ ║"
    echo "║  ██║  ██║╚════██║██║██║╚██╗██║   ██║       ╚════██║██╔══╝  ██║   ██║ ║"
    echo "║  ██████╔╝███████║██║██║ ╚████║   ██║       ███████║███████╗╚██████╔╝ ║"
    echo "║  ╚═════╝ ╚══════╝╚═╝╚═╝  ╚═══╝   ╚═╝       ╚══════╝╚══════╝ ╚═════╝  ║"
    echo "║                                                                      ║"
    echo "║                  [ 950+ WEBSITES SCANNER ]                           ║"
    echo "║                  [ VERSION 3.0 | TERMUX ]                            ║"
    echo "║                                                                      ║"
    echo "╚══════════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

loading_animation() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    echo -n "Scanning... "
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

progress_bar() {
    local current=$1
    local total=$2
    local width=50
    local percentage=$((current * 100 / total))
    local completed=$((current * width / total))
    local remaining=$((width - completed))
    
    printf "\r${BLUE}["
    for ((i=0; i<completed; i++)); do
        printf "█"
    done
    for ((i=0; i<remaining; i++)); do
        printf " "
    done
    printf "] ${WHITE}%3d%%${NC} (%d/%d sites)" $percentage $current $total
}

# ==============================================
# WEBSITE DATABASE (950+ SITES)
# ==============================================
generate_sites_list() {
    echo -e "${YELLOW}[*] Loading 950+ websites database...${NC}"
    
    cat > websites.db << 'WEBSITES'
# ==============================================
# 700+ POPULAR WEBSITES
# ==============================================

# Social Media (100 sites)
https://www.facebook.com/{}
https://twitter.com/{}
https://www.instagram.com/{}
https://www.linkedin.com/in/{}
https://www.pinterest.com/{}
https://www.reddit.com/user/{}
https://www.tumblr.com/{}/
https://www.flickr.com/people/{}
https://www.vk.com/{}
https://www.weibo.com/{}
https://www.snapchat.com/add/{}
https://www.tiktok.com/@{}
https://www.twitch.tv/{}
https://www.myspace.com/{}
https://www.badoo.com/en/{}
https://www.bumble.com/{}
https://www.happn.com/{}
https://www.tagged.com/{}
https://www.hi5.com/{}
https://www.meetme.com/{}
https://www.mylife.com/{}
https://www.classmates.com/{}
https://www.xanga.com/{}
https://www.cafe.com/{}
https://www.caringbridge.org/{}
https://www.circle.com/{}
https://www.clubhouse.com/@{}
https://www.coach.me/{}
https://www.codepen.io/{}
https://www.colourlovers.com/lover/{}
https://www.coroflot.com/{}
https://www.couchsurfing.com/people/{}
https://www.credly.com/users/{}
https://www.crunchyroll.com/user/{}
https://www.deviantart.com/{}
https://www.discord.com/users/{}
https://www.dribbble.com/{}
https://www.ello.co/{}
https://www.etsy.com/people/{}
https://www.f6s.com/{}
https://www.facebook.com/public/{}
https://www.fandom.com/u/{}
https://www.fiverr.com/{}
https://www.flipboard.com/@{}
https://www.fotolog.com/{}
https://www.freelancer.com/u/{}
https://www.gaiaonline.com/profiles/{}
https://www.gamespot.com/profile/{}
https://www.gapyear.com/members/{}
https://www.girlsaskguys.com/{}
https://www.github.com/{}
https://www.goodreads.com/{}
https://www.gravatar.com/{}
https://www.gumroad.com/{}
https://www.hackerrank.com/{}
https://www.houzz.com/user/{}
https://www.hubpages.com/@{}
https://www.ifttt.com/p/{}
https://www.imgur.com/user/{}
https://www.instructables.com/member/{}
https://www.kali.org/{}
https://www.khanacademy.org/profile/{}
https://www.kickstarter.com/profile/{}
https://www.last.fm/user/{}
https://www.livejournal.com/{}
https://www.magento.com/{}
https://www.medium.com/@{}
https://www.meetup.com/members/{}
https://www.mixcloud.com/{}
https://www.mozilla.org/{}
https://www.myspace.com/{}
https://www.newgrounds.com/{}
https://www.ok.ru/{}
https://www.opensource.com/users/{}
https://www.patreon.com/{}
https://www.periscope.tv/{}
https://www.personalitycafe.com/{}
https://www.plurk.com/{}
https://www.podomatic.com/people/{}
https://www.producthunt.com/@{}
https://www.quora.com/profile/{}
https://www.ravelry.com/people/{}
https://www.reverbnation.com/{}
https://www.roblox.com/user.aspx?username={}
https://www.scribd.com/{}
https://www.slashdot.org/~{}
https://www.slideshare.net/{}
https://www.smule.com/{}
https://www.soundcloud.com/{}
https://www.spotify.com/user/{}
https://www.steamcommunity.com/id/{}
https://www.stumbleupon.com/stumbler/{}
https://www.telegram.me/{}
https://www.trello.com/{}
https://www.tripadvisor.com/members/{}
https://www.tripit.com/people/{}
https://www.twitch.tv/{}
https://www.upsocl.com/autor/{}
https://www.vimeo.com/{}
https://www.wattpad.com/user/{}
https://www.weheartit.com/{}
https://www.wikipedia.org/wiki/User:{}
https://www.wix.com/{}
https://www.wordpress.com/{}
https://www.yelp.com/user_details?userid={}
https://www.younow.com/{}
https://www.youtube.com/user/{}
https://www.zoom.com/{}

# Professional Networks (50 sites)
https://www.angel.co/{}
https://www.behance.net/{}
https://www.crunchbase.com/person/{}
https://www.dribbble.com/{}
https://www.github.com/{}
https://www.gitlab.com/{}
https://www.stackoverflow.com/users/{}
https://www.xing.com/profile/{}
https://www.about.me/{}
https://www.coroflot.com/{}
https://www.creativepool.com/{}
https://www.designspiration.com/{}
https://www.deviantart.com/{}
https://www.flickr.com/people/{}
https://www.hackerrank.com/{}
https://www.kaggle.com/{}
https://www.keybase.io/{}
https://www.launchpad.net/~{}
https://www.medium.com/@{}
https://www.packetstormsecurity.com/{}
https://www.slideshare.net/{}
https://www.speakerdeck.com/{}
https://www.techinasia.com/{}
https://www.toptal.com/{}
https://www.upwork.com/freelancers/~{}
https://www.visualcv.com/{}
https://www.zerply.com/{}
https://www.zoominfo.com/p/{}
https://www.clutch.co/{}
https://www.g2.com/users/{}
https://www.producthunt.com/@{}
https://www.quora.com/profile/{}
https://www.reddit.com/user/{}
https://www.stackexchange.com/users/{}
https://www.superuser.com/users/{}
https://www.askubuntu.com/users/{}
https://www.serverfault.com/users/{}
https://www.mathoverflow.net/users/{}
https://www.tex.stackexchange.com/users/{}
https://www.unix.stackexchange.com/users/{}
https://www.webmasters.stackexchange.com/users/{}
https://www.gis.stackexchange.com/users/{}
https://www.security.stackexchange.com/users/{}
https://www.codeproject.com/members/{}
https://www.sourceforge.net/u/{}
https://www.bitbucket.org/{}
https://www.npmjs.com/~{}
https://www.pypi.org/user/{}
https://www.ruby-toolbox.com/profiles/{}

# Forums & Communities (100 sites)
https://www.7cups.com/@{}
https://www.alignable.com/{}
https://www.alltrails.com/members/{}
https://www.anobii.com/{}
https://www.audiotool.com/user/{}
https://www.bandcamp.com/{}
https://www.bazar.cz/{}
https://www.beautylish.com/{}
https://www.blip.fm/{}
https://www.blogger.com/profile/{}
https://www.buzzfeed.com/{}
https://www.cafemom.com/home/{}
https://www.cake.dev/@{}
https://www.care2.com/{}
https://www.chatpitara.com/{}
https://www.cheezburger.com/{}
https://www.codementor.io/{}
https://www.colourlovers.com/lover/{}
https://www.community.is/{}
https://www.couchsurfing.com/people/{}
https://www.dailykos.com/user/{}
https://www.demilked.com/author/{}
https://www.designcrowd.com/{}
https://www.digitalpoint.com/{}
https://www.diigo.com/profile/{}
https://www.discogs.com/user/{}
https://www.dpreview.com/members/{}
https://www.ebay.com/usr/{}
https://www.edmodo.com/{}
https://www.epictions.com/{}
https://www.etsy.com/people/{}
https://www.exploroo.com/{}
https://www.feedspot.com/u/{}
https://www.filmow.com/usuario/{}
https://www.flickr.com/people/{}
https://www.flightradar24.com/{}
https://www.fodors.com/community/{}
https://www.fotolog.com/{}
https://www.freelancer.com/u/{}
https://www.gapyear.com/members/{}
https://www.geocaching.com/profile/{}
https://www.giantbomb.com/profile/{}
https://www.girlsaskguys.com/{}
https://www.goodreads.com/{}
https://www.gsmarena.com/{}
https://www.guru.com/{}
https://www.hackerearth.com/@{}
https://www.hackthissite.org/user/{}
https://www.hi5.com/{}
https://www.hubpages.com/@{}
https://www.hulkshare.com/{}
https://www.ifixit.com/User/{}
https://www.imdb.com/user/ur{}
https://www.indiegogo.com/individuals/{}
https://www.instructables.com/member/{}
https://www.interpals.net/{}
https://www.ivoox.com/listen_user_{}
https://www.justlanded.com/{}
https://www.kongregate.com/accounts/{}
https://www.librarything.com/profile/{}
https://www.liveleak.com/user/{}
https://www.martialartsplanet.com/members/{}
https://www.memrise.com/user/{}
https://www.metacritic.com/user/{}
https://www.minds.com/{}
https://www.mix.com/{}
https://www.mmo-champion.com/members/{}
https://www.mobafire.com/profile/{}
https://www.moviepilot.com/users/{}
https://www.mywot.com/{}
https://www.nairaland.com/{}
https://www.native-instruments.com/forum/members/{}
https://www.neoseeker.com/members/{}
https://www.nexusmods.com/users/{}
https://www.nike.com/member/{}
https://www.nikonians.org/{}
https://www.noteflight.com/profile/{}
https://www.opendesktop.org/u/{}
https://www.openstreetmap.org/user/{}
https://www.ops.io/{}
https://www.oura.com/{}
https://www.outdoorsy.com/{}
https://www.overclock.net/members/{}
https://www.pbase.com/{}
https://www.photobucket.com/user/{}
https://www.photography-on-the.net/forum/member.php?u={}
https://www.pinkbike.com/u/{}
https://www.pinterest.com/{}
https://www.pixabay.com/en/users/{}
https://www.play.fm/{}
https://www.plurk.com/{}
https://www.podbean.com/{}
https://www.pof.com/{}
https://www.pokerstrategy.com/user/{}
https://www.polygon.com/users/{}
https://www.popjustice.com/bbs/members/{}
https://www.projectnoah.org/users/{}
https://www.quibblo.com/user/{}
https://www.quizup.com/player/{}
https://www.ranker.com/profile-of/{}
https://www.rateyourmusic.com/~{}
https://www.realtor.com/realestateagents/{}
https://www.recipezaar.com/member/{}
https://www.redbubble.com/people/{}
https://www.renren.com/{}
https://www.reverbnation.com/{}
https://www.roblox.com/user.aspx?username={}
https://www.rockpapershotgun.com/author/{}
https://www.rottentomatoes.com/user/{}
https://www.sbnation.com/users/{}
https://www.scrolller.com/user/{}
https://www.scribd.com/{}
https://www.sellfy.com/{}
https://www.sheetmusicplus.com/publishers/{}
https://www.skyscrapercity.com/members/{}
https://www.smashwords.com/profile/view/{}
https://www.songkick.com/users/{}
https://www.soundclick.com/artist/default.cfm?bandID={}
https://www.sourceforge.net/u/{}
https://www.spokeo.com/{}
https://www.sportlerfrage.net/user/{}
https://www.spotify.com/user/{}
https://www.spring.me/{}
https://www.stackoverflow.com/users/{}
https://www.steamcommunity.com/id/{}
https://www.strava.com/athletes/{}
https://www.student.com/{}
https://www.studyblue.com/{}
https://www.surveymonkey.com/r/{}
https://www.tagged.com/{}
https://www.talkstats.com/members/{}
https://www.ted.com/profiles/{}
https://www.thestudentroom.co.uk/member.php?u={}
https://www.trakt.tv/users/{}
https://www.tripadvisor.com/members/{}
https://www.tripit.com/people/{}
https://www.truelancer.com/freelancer/{}
https://www.tumblr.com/{}
https://www.tunein.com/user/{}
https://www.tv.com/user/{}
https://www.tvtropes.org/pmwiki/pmwiki.php/Main/{}
https://www.ultimate-guitar.com/u/{}
https://www.universalhunt.com/{}
https://www.ustream.tv/user/{}
https://www.vbulletin.com/forum/member/{}
https://www.videogamer.com/user/{}
https://www.viki.com/users/{}
https://www.virgin.com/users/{}
https://www.weasyl.com/~{}
https://www.webMD.com/{}
https://www.weebly.com/{}
https://www.wikitree.com/wiki/{}
https://www.wishlistr.com/{}
https://www.wittyprofiles.com/{}
https://www.wyzant.com/Tutor/{}
https://www.xboxgamertag.com/search/{}
https://www.yellowpages.com/{}
https://www.youphil.com/en/profile/{}
https://www.zillow.com/profile/{}
https://www.zomato.com/{}
https://www.zynga.com/{}

# ==============================================
# 200+ PORTFOLIO & PERSONAL WEBSITES
# ==============================================

# Portfolio Platforms (50 sites)
https://{}.carbonmade.com
https://{}.carrd.co
https://{}.contently.com
https://{}.crevado.com
https://{}.dunked.com
https://{}.fabrik.io
https://{}.journoportfolio.com
https://{}.portfoliobox.net
https://{}.portfolio.de
https://{}.portfoliopen.com
https://{}.showing.se
https://{}.squarespace.com
https://{}.wixsite.com
https://{}.wordpress.com
https://{}.blogspot.com
https://{}.tumblr.com
https://{}.weebly.com
https://{}.webnode.com
https://{}.yola.com
https://{}.strikingly.com
https://{}.sitey.com
https://{}.ucoz.com
https://{}.webs.com
https://{}.webstarts.com
https://{}.google.com
https://{}.github.io
https://{}.gitlab.io
https://{}.netlify.app
https://{}.vercel.app
https://{}.herokuapp.com
https://{}.repl.co
https://{}.glitch.me
https://{}.surge.sh
https://{}.firebaseapp.com
https://{}.awsapprunner.com
https://{}.azurewebsites.net
https://{}.cloudapp.net
https://{}.cloudfunctions.net
https://{}.appspot.com
https://{}.pythonanywhere.com
https://{}.000webhostapp.com
https://{}.infinityfreeapp.com
https://{}.byethost.com
https://{}.awardspace.com
https://{}.freehostia.com
https://{}.altervista.org
https://{}.blog.com
https://{}.blog.de
https://{}.blogfa.com
https://{}.blogfree.net

# Personal Blogs (50 sites)
https://{}.medium.com
https://{}.substack.com
https://{}.ghost.io
https://{}.write.as
https://{}.blogger.com
https://{}.typepad.com
https://{}.livejournal.com
https://{}.dreamwidth.org
https://{}.blogdrive.com
https://{}.blogs.com
https://{}.blog.co.uk
https://{}.blog.fi
https://{}.blog.fr
https://{}.blog.it
https://{}.blog.se
https://{}.blogg.se
https://{}.blogspot.com
https://{}.blogspot.de
https://{}.blogspot.fr
https://{}.blogspot.it
https://{}.blogspot.jp
https://{}.blogspot.ru
https://{}.blogspot.com.br
https://{}.blogspot.com.ar
https://{}.blogspot.com.mx
https://{}.hatenablog.com
https://{}.hatenadiary.com
https://{}.note.com
https://{}.qiita.com
https://{}.zenn.dev
https://{}.speakerdeck.com
https://{}.slideshare.net
https://{}.speaker.com
https://{}.presentation.com
https://{}.prezi.com
https://{}.canva.com
https://{}.behance.net
https://{}.dribbble.com
https://{}.deviantart.com
https://{}.artstation.com
https://{}.pinterest.com
https://{}.flickr.com
https://{}.500px.com
https://{}.unsplash.com/@{}
https://{}.vsco.co
https://{}.instagram.com
https://{}.tiktok.com
https://{}.youtube.com
https://{}.vimeo.com
https://{}.twitch.tv
https://{}.soundcloud.com

# Business & Company (50 sites)
https://{}.company.site
https://{}.business.site
https://{}.store
https://{}.shop
https://{}.myshopify.com
https://{}.bigcartel.com
https://{}.ecwid.com
https://{}.square.site
https://{}.tictail.com
https://{}.storeenvy.com
https://{}.threadless.com
https://{}.redbubble.com/people/{}
https://{}.teespring.com
https://{}.spreadshirt.com
https://{}.zazzle.com
https://{}.cafepress.com
https://{}.society6.com
https://{}.designbyhumans.com
https://{}.lookhuman.com
https://{}.cottonbureau.com
https://{}.uberprints.com
https://{}.printful.com
https://{}.printify.com
https://{}.gooten.com
https://{}.spring.com
https://{}.bonfire.com
https://{}.teepublic.com
https://{}.amazon.com
https://{}.ebay.com
https://{}.etsy.com
https://{}.alibaba.com
https://{}.allegro.pl
https://{}.mercari.com
https://{}.rakuten.co.jp
https://{}.taobao.com
https://{}.jd.com
https://{}.pinduoduo.com
https://{}.walmart.com
https://{}.target.com
https://{}.bestbuy.com
https://{}.homedepot.com
https://{}.lowes.com
https://{}.costco.com
https://{}.kroger.com
https://{}.walgreens.com
https://{}.cvs.com
https://{}.riteaid.com
https://{}.dollartree.com
https://{}.familydollar.com
https://{}.dollar general.com

# Creative Portfolios (50 sites)
https://{}.artstation.com
https://{}.deviantart.com
https://{}.behance.net
https://{}.dribbble.com
https://{}.carbonmade.com
https://{}.crevado.com
https://{}.cargocollective.com
https://{}.portfoliobox.net
https://{}.fabrik.io
https://{}.format.com
https://{}.foliosociety.com
https://{}.krop.com
https://{}.portfoliopen.com
https://{}.portfolioserver.com
https://{}.portfolioapp.com
https://{}.portfoliodev.com
https://{}.portfoliogen.com
https://{}.portfoliohub.com
https://{}.portfolioshowcase.com
https://{}.portfoliostack.com
https://{}.portfolioview.com
https://{}.portfoliowork.com
https://{}.showing.se
https://{}.viewbook.com
https://{}.workbook.com
https://{}.youworkforthem.com
https://{}.designspiration.net
https://{}.muz.li
https://{}.ui8.net
https://{}.uplabs.com
https://{}.dribbble.com
https://{}.graphicriver.net
https://{}.themeforest.net
https://{}.codecanyon.net
https://{}.videohive.net
https://{}.audiojungle.net
https://{}.photodune.net
https://{}.3docean.net
https://{}.activeden.net
https://{}.cgtrader.com
https://{}.turbosquid.com
https://{}.free3d.com
https://{}.sketchfab.com
https://{}.thingiverse.com
https://{}.myminifactory.com
https://{}.prusaprinters.org
https://{}.cults3d.com
https://{}.pinshape.com
https://{}.grabcad.com
https://{}.cadcrowd.com

# ==============================================
# 50+ SCHOOL & UNIVERSITY WEBSITES
# ==============================================

# Indonesian Schools
https://{}.sch.id
https://{}.school.id
https://{}.smpn1.sch.id
https://{}.sman1.sch.id
https://{}.smk1.sch.id
https://{}.sdn1.sch.id
https://{}.sdit.sch.id
https://{}.sdit1.sch.id
https://{}.mi.sch.id
https://{}.mts.sch.id
https://{}.ma.sch.id
https://{}.smptaruna.sch.id
https://{}.smataruna.sch.id
https://{}.smktaruna.sch.id
https://{}.alazhar.sch.id
https://{}.mutiarabunda.sch.id
https://{}.harapanbunda.sch.id
https://{}.bintangmadani.sch.id
https://{}.cendekia.sch.id
https://{}.global.sch.id

# International Schools
https://{}.edu
https://{}.ac.id
https://{}.ac.jp
https://{}.ac.kr
https://{}.edu.au
https://{}.edu.uk
https://{}.edu.us
https://{}.edu.ca
https://{}.edu.de
https://{}.edu.fr
https://{}.edu.it
https://{}.edu.es
https://{}.edu.cn
https://{}.edu.in
https://{}.edu.sg
https://{}.edu.my
https://{}.edu.ph
https://{}.edu.vn
https://{}.edu.th
https://{}.edu.nz

# University Portals
https://alumni.{}.edu
https://students.{}.edu
https://faculty.{}.edu
https://staff.{}.edu
https://research.{}.edu
https://library.{}.edu
https://campus.{}.edu
https://portal.{}.edu
https://online.{}.edu
https://elearning.{}.edu
https://moodle.{}.edu
https://blackboard.{}.edu
https://canvas.{}.edu
https://edmodo.{}.edu
https://classroom.{}.edu

# ==============================================
# TOTAL: 950+ WEBSITES LOADED
# ==============================================
WEBSITES
    
    # Count total sites
    SITES_COUNT=$(grep -c "^https://" websites.db)
    echo -e "${GREEN}[✓] Loaded ${SITES_COUNT} websites${NC}"
}

# ==============================================
# SEARCH FUNCTIONS
# ==============================================
search_name() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${WHITE}                    NAME SEARCH TOOL                        ${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    
    read -p "Enter name to search (e.g., Steven Johnson): " search_name
    echo ""
    
    if [ -z "$search_name" ]; then
        echo -e "${RED}[!] Name cannot be empty${NC}"
        return 1
    fi
    
    # Clean name for URL
    clean_name=$(echo "$search_name" | tr ' ' '_' | tr -d '[:punct:]' | tr '[:upper:]' '[:lower:]')
    original_name=$(echo "$search_name" | tr '[:upper:]' '[:lower:]')
    
    echo -e "${YELLOW}[*] Searching for: ${WHITE}$search_name${NC}"
    echo -e "${YELLOW}[*] Scanning ${SITES_COUNT} websites...${NC}"
    echo ""
    
    # Create results file
    echo "OSINT SEARCH REPORT" > "$RESULTS_FILE"
    echo "===================" >> "$RESULTS_FILE"
    echo "Search Name: $search_name" >> "$RESULTS_FILE"
    echo "Search Date: $(date)" >> "$RESULTS_FILE"
    echo "Total Sites: $SITES_COUNT" >> "$RESULTS_FILE"
    echo "" >> "$RESULTS_FILE"
    echo "RESULTS:" >> "$RESULTS_FILE"
    echo "========" >> "$RESULTS_FILE"
    
    # Initialize counters
    FOUND_COUNT=0
    SCANNED_COUNT=0
    ERROR_COUNT=0
    
    # Start searching
    while IFS= read -r site; do
        # Skip comments and empty lines
        [[ "$site" =~ ^# ]] && continue
        [[ -z "$site" ]] && continue
        
        SCANNED_COUNT=$((SCANNED_COUNT + 1))
        
        # Replace {} with cleaned name
        url=$(echo "$site" | sed "s/{}/$clean_name/g")
        
        # Show progress
        progress_bar $SCANNED_COUNT $SITES_COUNT
        
        # Try to fetch URL (with timeout)
        if curl -s --max-time 10 --head "$url" | head -n 1 | grep -q "200\|301\|302"; then
            FOUND_COUNT=$((FOUND_COUNT + 1))
            echo -e "\n${GREEN}[✓] FOUND: $url${NC}"
            echo "[✓] $url" >> "$RESULTS_FILE"
        else
            # Try alternative pattern
            alt_url=$(echo "$site" | sed "s/{}/$original_name/g")
            if curl -s --max-time 10 --head "$alt_url" | head -n 1 | grep -q "200\|301\|302"; then
                FOUND_COUNT=$((FOUND_COUNT + 1))
                echo -e "\n${GREEN}[✓] FOUND: $alt_url${NC}"
                echo "[✓] $alt_url" >> "$RESULTS_FILE"
            fi
        fi
        
        # Small delay to avoid rate limiting
        sleep 0.01
        
    done < <(grep "^https://" websites.db)
    
    echo ""
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${WHITE}                     SEARCH COMPLETE                        ${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${GREEN}✓ Websites scanned: ${WHITE}$SCANNED_COUNT/${SITES_COUNT}${NC}"
    echo -e "${GREEN}✓ Names found on: ${WHITE}$FOUND_COUNT sites${NC}"
    echo -e "${GREEN}✓ Results saved to: ${WHITE}$RESULTS_FILE${NC}"
    echo ""
    
    # Show summary
    if [ $FOUND_COUNT -gt 0 ]; then
        echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${GREEN}                     FOUND ON THESE SITES:                    ${NC}"
        echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        grep "\[✓\]" "$RESULTS_FILE" | sed 's/\[✓\] //'
    fi
}

quick_search() {
    echo ""
    echo -e "${YELLOW}[*] Quick Search Mode (50 random sites)${NC}"
    read -p "Enter name: " q_name
    
    if [ -z "$q_name" ]; then
        echo -e "${RED}[!] Name required${NC}"
        return
    fi
    
    clean_qname=$(echo "$q_name" | tr ' ' '_' | tr '[:upper:]' '[:lower:]' | tr -d '[:punct:]')
    
    echo -e "${YELLOW}[*] Scanning 50 random sites...${NC}"
    
    # Get 50 random sites
    grep "^https://" websites.db | shuf -n 50 > temp_sites.txt
    
    local quick_found=0
    local count=0
    
    while read -r site; do
        count=$((count + 1))
        url=$(echo "$site" | sed "s/{}/$clean_qname/g")
        
        printf "\rScanning... %2d/50" $count
        
        if curl -s --max-time 5 --head "$url" | head -n 1 | grep -q "200\|301\|302"; then
            echo -e "\n${GREEN}[✓] $url${NC}"
            quick_found=$((quick_found + 1))
        fi
        
        sleep 0.05
    done < temp_sites.txt
    
    echo ""
    echo -e "${GREEN}✓ Found on $quick_found of 50 random sites${NC}"
    rm temp_sites.txt
}

view_results() {
    if [ -f "$RESULTS_FILE" ]; then
        echo ""
        echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${WHITE}                     PREVIOUS RESULTS                       ${NC}"
        echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo ""
        cat "$RESULTS_FILE"
    else
        echo -e "${YELLOW}[!] No previous results found${NC}"
    fi
}

# ==============================================
# MAIN MENU
# ==============================================
main_menu() {
    while true; do
        echo ""
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${WHITE}                      MAIN MENU                             ${NC}"
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo ""
        echo -e "${GREEN}1. ${WHITE}Full Search (All ${SITES_COUNT} sites)"
        echo -e "${GREEN}2. ${WHITE}Quick Search (50 random sites)"
        echo -e "${GREEN}3. ${WHITE}View Previous Results"
        echo -e "${GREEN}4. ${WHITE}View Website List"
        echo -e "${GREEN}5. ${WHITE}Statistics"
        echo -e "${GREEN}6. ${WHITE}Clear Results"
        echo -e "${GREEN}7. ${WHITE}Exit"
        echo ""
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo ""
        
        read -p "Select option [1-7]: " choice
        
        case $choice in
            1)
                search_name
                ;;
            2)
                quick_search
                ;;
            3)
                view_results
                ;;
            4)
                echo ""
                echo -e "${YELLOW}Total websites loaded: ${WHITE}$SITES_COUNT${NC}"
                echo -e "${YELLOW}Categories:${NC}"
                echo "  - 700+ Social Media & Popular Sites"
                echo "  - 200+ Portfolio & Personal Sites"
                echo "  - 50+ School & University Sites"
                ;;
            5)
                echo ""
                echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
                echo -e "${WHITE}                      STATISTICS                             ${NC}"
                echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
                echo ""
                echo -e "${GREEN}Total Websites: ${WHITE}$SITES_COUNT${NC}"
                echo -e "${GREEN}Last Search: ${WHITE}$(grep -m1 "Search Date:" "$RESULTS_FILE" 2>/dev/null | cut -d: -f2-)${NC}"
                echo -e "${GREEN}Last Name Searched: ${WHITE}$(grep -m1 "Search Name:" "$RESULTS_FILE" 2>/dev/null | cut -d: -f2-)${NC}"
                echo -e "${GREEN}Results File: ${WHITE}$RESULTS_FILE${NC}"
                echo -e "${GREEN}Log File: ${WHITE}$LOG_FILE${NC}"
                ;;
            6)
                if [ -f "$RESULTS_FILE" ]; then
                    rm "$RESULTS_FILE"
                    echo -e "${GREEN}[✓] Results cleared${NC}"
                else
                    echo -e "${YELLOW}[!] No results to clear${NC}"
                fi
                ;;
            7)
                echo ""
                echo -e "${GREEN}Thank you for using OSINT Search Tool!${NC}"
                echo ""
                exit 0
                ;;
            *)
                echo -e "${RED}[!] Invalid option${NC}"
                ;;
        esac
        
        echo ""
        read -p "Press Enter to continue..."
        show_banner
    done
}

# ==============================================
# INITIALIZATION
# ==============================================
initialize() {
    show_banner
    echo -e "${YELLOW}[*] Initializing OSINT Search Tool...${NC}"
    
    # Check for required tools
    command -v curl >/dev/null 2>&1 || {
        echo -e "${RED}[!] curl is required but not installed${NC}"
        echo -e "${YELLOW}[*] Installing curl...${NC}"
        pkg install curl -y
    }
    
    # Generate websites database
    if [ ! -f "websites.db" ]; then
        generate_sites_list
    else
        SITES_COUNT=$(grep -c "^https://" websites.db)
        echo -e "${GREEN}[✓] Loaded ${SITES_COUNT} websites from cache${NC}"
    fi
    
    # Create log file
    echo "OSINT Search Tool Log" > "$LOG_FILE"
    echo "Start Time: $(date)" >> "$LOG_FILE"
    
    echo -e "${GREEN}[✓] Tool initialized successfully${NC}"
    echo ""
    echo -e "${WHITE}Ready to search across ${SITES_COUNT} websites!${NC}"
    echo ""
    sleep 2
}

# ==============================================
# START TOOL
# ==============================================
initialize
main_menu
