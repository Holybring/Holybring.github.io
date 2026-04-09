<!DOCTYPE html>

<html lang="th">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>FORENSIC — ระบบงานนิติเวช โรงพยาบาลกระบี่</title>
<link href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;500;600;700&family=Chakra+Petch:wght@400;600;700&family=IBM+Plex+Mono:wght@400;600&display=swap" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.min.js"></script>
<style>
/* ═══════════════════════════════════════════════
   ROOT VARIABLES — Medical Dark Theme
═══════════════════════════════════════════════ */
:root {
  --bg:       #0D1117;
  --bg2:      #161B22;
  --bg3:      #1C2330;
  --bg4:      #21262D;
  --border:   #30363D;
  --border2:  #3D444D;
  --text:     #E6EDF3;
  --text2:    #8B949E;
  --text3:    #6E7681;

–blue:     #2F81F7;
–blue-dim: #1F4A8C;
–blue-bg:  #0D1F3C;
–teal:     #2DD4BF;
–teal-dim: #14786E;
–teal-bg:  #062820;
–purple:   #A78BFA;
–purple-dim:#5B21B6;
–purple-bg:#1E1035;
–green:    #3FB950;
–green-dim:#1A5928;
–green-bg: #0D2B14;
–orange:   #F0883E;
–orange-dim:#7D3E10;
–orange-bg:#2A1500;
–red:      #F85149;
–red-dim:  #8B1A18;
–red-bg:   #2D0B0A;
–yellow:   #E3B341;
–yellow-dim:#7B5C0D;
–yellow-bg:#231A00;
–pink:     #F778BA;
–pink-dim: #8B2E5A;
–pink-bg:  #2A0E1E;

–font-body: ‘Sarabun’, sans-serif;
–font-head: ‘Chakra Petch’, sans-serif;
–font-mono: ‘IBM Plex Mono’, monospace;

–radius:   10px;
–radius-lg:16px;
–shadow:   0 4px 24px rgba(0,0,0,0.4);
–shadow-lg:0 8px 48px rgba(0,0,0,0.6);

–topbar-h: 56px;
–sidebar-w:220px;
}

*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
html{font-size:14px;scroll-behavior:smooth}
body{font-family:var(–font-body);background:var(–bg);color:var(–text);min-height:100vh;overflow-x:hidden}

/* ── SCROLLBAR ── */
::-webkit-scrollbar{width:5px;height:5px}
::-webkit-scrollbar-track{background:transparent}
::-webkit-scrollbar-thumb{background:var(–border2);border-radius:3px}
::-webkit-scrollbar-thumb:hover{background:var(–text3)}

/* ═══════════════════════════════════════════════
TOPBAR
═══════════════════════════════════════════════ */
.topbar{
position:fixed;top:0;left:0;right:0;z-index:200;
height:var(–topbar-h);
background:linear-gradient(90deg,#0A0F16 0%,var(–bg2) 100%);
border-bottom:1px solid var(–border);
display:flex;align-items:center;padding:0 20px;gap:16px;
}
.topbar-logo{
font-family:var(–font-head);font-size:1.15rem;font-weight:700;
color:var(–teal);letter-spacing:2px;white-space:nowrap;
}
.topbar-logo span{color:var(–text3);font-size:0.7rem;display:block;font-weight:400;letter-spacing:1px;margin-top:-2px}
.topbar-divider{width:1px;height:28px;background:var(–border);flex-shrink:0}
.topbar-info{flex:1;display:flex;align-items:center;gap:16px;overflow:hidden}
.topbar-info .t-hosp{font-size:0.9rem;font-weight:600;color:var(–text);white-space:nowrap}
.topbar-info .t-dept{font-size:0.75rem;color:var(–text3);white-space:nowrap}
.topbar-right{display:flex;align-items:center;gap:12px;margin-left:auto}
.topbar-clock{font-family:var(–font-mono);font-size:0.8rem;color:var(–teal);background:var(–teal-bg);padding:4px 10px;border-radius:6px;border:1px solid var(–teal-dim)}
.topbar-hosxp{font-size:0.72rem;padding:4px 10px;border-radius:6px;border:1px solid var(–border2);background:var(–bg3);color:var(–text2);cursor:pointer;transition:all .15s}
.topbar-hosxp:hover{border-color:var(–blue);color:var(–blue)}
.topbar-hosxp.connected{border-color:var(–green);color:var(–green)}

/* ═══════════════════════════════════════════════
LAYOUT
═══════════════════════════════════════════════ */
.layout{display:flex;padding-top:var(–topbar-h);height:100vh}

/* ═══════════════════════════════════════════════
SIDEBAR
═══════════════════════════════════════════════ */
.sidebar{
width:var(–sidebar-w);flex-shrink:0;
background:var(–bg2);border-right:1px solid var(–border);
display:flex;flex-direction:column;overflow-y:auto;
padding:16px 0;gap:2px;
}
.sb-section{
font-size:0.65rem;font-weight:700;color:var(–text3);
text-transform:uppercase;letter-spacing:1.5px;
padding:12px 16px 4px;
}
.sb-item{
display:flex;align-items:center;gap:10px;
padding:9px 16px;cursor:pointer;transition:all .15s;
color:var(–text2);font-size:0.88rem;font-family:var(–font-body);
border:none;background:none;width:100%;text-align:left;
border-left:3px solid transparent;position:relative;
}
.sb-item:hover{background:rgba(255,255,255,0.04);color:var(–text)}
.sb-item.active{
background:linear-gradient(90deg,rgba(47,129,247,0.12) 0%,transparent 100%);
color:var(–blue);border-left-color:var(–blue);
}
.sb-icon{width:20px;text-align:center;font-size:1rem;flex-shrink:0}
.sb-badge{
margin-left:auto;background:var(–bg4);color:var(–text3);
font-family:var(–font-mono);font-size:0.65rem;
padding:1px 6px;border-radius:10px;border:1px solid var(–border);
}
.sb-item.active .sb-badge{background:var(–blue-bg);color:var(–blue);border-color:var(–blue-dim)}

/* capacity mini widget */
.sb-capacity{
margin:4px 12px;background:var(–bg3);border:1px solid var(–border);
border-radius:var(–radius);padding:10px 12px;
}
.sb-cap-title{font-size:0.7rem;color:var(–text3);margin-bottom:6px;font-weight:600}
.sb-cap-bar{height:6px;background:var(–bg4);border-radius:3px;overflow:hidden;margin-bottom:4px}
.sb-cap-fill{height:100%;border-radius:3px;transition:width .4s ease}
.sb-cap-nums{display:flex;justify-content:space-between;font-family:var(–font-mono);font-size:0.7rem}

/* ═══════════════════════════════════════════════
MAIN CONTENT
═══════════════════════════════════════════════ */
.main{flex:1;overflow-y:auto;overflow-x:hidden}

/* ── PAGE ── */
.page{display:none;padding:24px;animation:fadeUp .25s ease}
.page.active{display:block}
@keyframes fadeUp{from{opacity:0;transform:translateY(8px)}to{opacity:1;transform:translateY(0)}}

/* ── PAGE HERO ── */
.page-hero{
border-radius:var(–radius-lg);padding:24px 28px;margin-bottom:20px;
display:flex;align-items:center;gap:20px;position:relative;overflow:hidden;
}
.page-hero::before{
content:’’;position:absolute;right:-20px;top:-20px;
width:180px;height:180px;border-radius:50%;
opacity:.07;
}
.hero-icon{font-size:2.8rem;line-height:1;z-index:1;filter:drop-shadow(0 0 12px currentColor)}
.hero-text{z-index:1}
.hero-text h1{font-family:var(–font-head);font-size:1.4rem;font-weight:700;line-height:1.2}
.hero-text p{font-size:0.82rem;opacity:.7;margin-top:4px}
.hero-stats{margin-left:auto;display:flex;gap:12px;z-index:1}
.hero-stat{text-align:center;background:rgba(255,255,255,0.06);border-radius:var(–radius);padding:10px 16px;backdrop-filter:blur(10px)}
.hero-stat .hs-num{font-family:var(–font-mono);font-size:1.6rem;font-weight:600;line-height:1}
.hero-stat .hs-lbl{font-size:0.7rem;opacity:.7;margin-top:2px}

/* ═══════════════════════════════════════════════
CARDS
═══════════════════════════════════════════════ */
.card{
background:var(–bg2);border:1px solid var(–border);
border-radius:var(–radius-lg);padding:20px;margin-bottom:16px;
}
.card-title{
font-size:0.82rem;font-weight:700;color:var(–text2);
text-transform:uppercase;letter-spacing:0.8px;
margin-bottom:16px;padding-bottom:12px;
border-bottom:1px solid var(–border);
display:flex;align-items:center;gap:8px;
}
.card-title-accent{width:3px;height:14px;border-radius:2px;background:currentColor;flex-shrink:0}

/* ═══════════════════════════════════════════════
FORM
═══════════════════════════════════════════════ */
.form-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(190px,1fr));gap:14px}
.fg2{grid-column:span 2}.fg3{grid-column:span 3}.fg4{grid-column:span 4}
.form-group{display:flex;flex-direction:column;gap:5px}
.form-group label{font-size:0.75rem;font-weight:600;color:var(–text2);display:flex;align-items:center;gap:4px}
.req{color:var(–red);font-size:0.8rem}
.form-group input,.form-group select,.form-group textarea{
background:var(–bg3);border:1px solid var(–border2);
border-radius:8px;padding:9px 12px;font-size:0.88rem;
font-family:var(–font-body);color:var(–text);outline:none;
transition:border-color .15s,box-shadow .15s;width:100%;
}
.form-group input:focus,.form-group select:focus,.form-group textarea:focus{
border-color:var(–blue);box-shadow:0 0 0 3px rgba(47,129,247,0.15);
}
.form-group input::placeholder{color:var(–text3)}
.form-group input[readonly]{background:var(–bg4);color:var(–teal);font-family:var(–font-mono);font-weight:600;cursor:default}
.form-group textarea{resize:vertical;min-height:80px}
.form-hint{font-size:0.7rem;color:var(–text3);margin-top:2px}

/* checkbox toggle */
.toggle-group{display:flex;align-items:center;gap:10px;padding:9px 0}
.toggle-group label{font-size:0.88rem;color:var(–text);cursor:pointer;font-weight:500}
.toggle-check{width:18px;height:18px;accent-color:var(–teal);cursor:pointer;flex-shrink:0}

/* section selector tabs */
.seg-tabs{display:flex;gap:6px;margin-bottom:20px;background:var(–bg3);padding:4px;border-radius:10px;border:1px solid var(–border)}
.seg-tab{flex:1;padding:8px 12px;border:none;background:none;color:var(–text2);font-family:var(–font-body);font-size:0.85rem;font-weight:600;cursor:pointer;border-radius:7px;transition:all .15s;text-align:center}
.seg-tab.active{background:var(–blue);color:white;box-shadow:0 2px 8px rgba(47,129,247,0.4)}

/* ═══════════════════════════════════════════════
BUTTONS
═══════════════════════════════════════════════ */
.btn-row{display:flex;gap:10px;margin-top:20px;flex-wrap:wrap;align-items:center}
.btn{
display:inline-flex;align-items:center;gap:7px;
padding:10px 20px;border-radius:8px;font-size:0.88rem;
font-weight:700;border:none;cursor:pointer;font-family:var(–font-body);
transition:all .15s;white-space:nowrap;
}
.btn:active{transform:scale(.97)}
.btn-primary{background:var(–blue);color:white}
.btn-primary:hover{background:#1F6FEB;box-shadow:0 4px 16px rgba(47,129,247,0.4)}
.btn-teal{background:var(–teal);color:var(–bg)}
.btn-teal:hover{background:#14B8A6;box-shadow:0 4px 16px rgba(45,212,191,0.4)}
.btn-ghost{background:var(–bg3);color:var(–text2);border:1px solid var(–border2)}
.btn-ghost:hover{background:var(–bg4);color:var(–text);border-color:var(–text3)}
.btn-danger{background:var(–red-bg);color:var(–red);border:1px solid var(–red-dim)}
.btn-danger:hover{background:var(–red);color:white}
.btn-warning{background:var(–orange-bg);color:var(–orange);border:1px solid var(–orange-dim)}
.btn-sm{padding:5px 12px;font-size:0.78rem}
.edit-indicator{
display:none;align-items:center;gap:7px;padding:8px 14px;
background:var(–purple-bg);color:var(–purple);
border:1px solid var(–purple-dim);border-radius:8px;
font-size:0.82rem;font-weight:600;
}
.edit-indicator.show{display:flex;animation:blink 1.8s ease infinite}
@keyframes blink{0%,100%{opacity:1}50%{opacity:.6}}

/* ═══════════════════════════════════════════════
TABLES
═══════════════════════════════════════════════ */
.tbl-wrap{overflow-x:auto;border-radius:var(–radius);border:1px solid var(–border)}
table{width:100%;border-collapse:collapse;font-size:0.82rem}
thead tr{background:var(–bg4)}
thead th{
padding:11px 13px;text-align:center;font-weight:700;
color:var(–text2);white-space:nowrap;
font-family:var(–font-head);font-size:0.72rem;letter-spacing:.5px;
border-bottom:1px solid var(–border);
}
tbody tr{border-bottom:1px solid rgba(48,54,61,0.6);transition:background .1s;cursor:pointer}
tbody tr:last-child{border-bottom:none}
tbody tr:hover{background:rgba(47,129,247,0.05)}
tbody tr.alt{background:rgba(255,255,255,0.015)}
td{padding:10px 13px;text-align:center;vertical-align:middle}
td.left{text-align:left}
.td-num{background:var(–bg4);color:var(–text3);font-family:var(–font-mono);font-size:0.75rem;width:36px}

/* ── BADGES ── */
.badge{display:inline-flex;align-items:center;gap:4px;padding:2px 9px;border-radius:20px;font-size:0.73rem;font-weight:700;white-space:nowrap}
.badge::before{content:‘●’;font-size:0.5rem}
.bg-green{background:var(–green-bg);color:var(–green);border:1px solid var(–green-dim)}
.bg-orange{background:var(–orange-bg);color:var(–orange);border:1px solid var(–orange-dim)}
.bg-blue{background:var(–blue-bg);color:var(–blue);border:1px solid var(–blue-dim)}
.bg-purple{background:var(–purple-bg);color:var(–purple);border:1px solid var(–purple-dim)}
.bg-red{background:var(–red-bg);color:var(–red);border:1px solid var(–red-dim)}
.bg-gray{background:var(–bg3);color:var(–text2);border:1px solid var(–border)}
.bg-teal{background:var(–teal-bg);color:var(–teal);border:1px solid var(–teal-dim)}
.bg-yellow{background:var(–yellow-bg);color:var(–yellow);border:1px solid var(–yellow-dim)}
.bg-pink{background:var(–pink-bg);color:var(–pink);border:1px solid var(–pink-dim)}

/* ── ACTION BUTTONS ── */
.act-btn{
padding:3px 9px;border-radius:5px;font-size:0.73rem;border:1px solid transparent;
cursor:pointer;font-family:var(–font-body);font-weight:700;transition:all .12s;
background:none;
}
.act-edit{color:var(–blue);border-color:var(–blue-dim);background:var(–blue-bg)}
.act-edit:hover{background:var(–blue);color:white}
.act-del{color:var(–red);border-color:var(–red-dim);background:var(–red-bg)}
.act-del:hover{background:var(–red);color:white}

/* ── SEARCH ROW ── */
.search-row{display:flex;gap:10px;align-items:center;margin-bottom:14px;flex-wrap:wrap}
.search-row input{max-width:260px;background:var(–bg2);border:1px solid var(–border2);border-radius:8px;padding:8px 12px;color:var(–text);font-family:var(–font-body);font-size:0.85rem;outline:none}
.search-row input:focus{border-color:var(–blue)}
.rec-count{font-size:0.78rem;color:var(–text3);margin-left:auto;font-family:var(–font-mono)}

/* ═══════════════════════════════════════════════
CAPACITY WIDGET (main page)
═══════════════════════════════════════════════ */
.cap-widget{
background:linear-gradient(135deg,var(–bg2) 0%,var(–bg3) 100%);
border:1px solid var(–border);border-radius:var(–radius-lg);
padding:20px 24px;margin-bottom:20px;display:flex;gap:24px;align-items:center;
}
.cap-donut-wrap{width:100px;height:100px;flex-shrink:0;position:relative}
.cap-donut-wrap canvas{position:absolute;inset:0}
.cap-donut-center{
position:absolute;inset:0;display:flex;flex-direction:column;
align-items:center;justify-content:center;pointer-events:none;
}
.cap-donut-num{font-family:var(–font-mono);font-size:1.5rem;font-weight:700;line-height:1}
.cap-donut-lbl{font-size:0.65rem;color:var(–text3);margin-top:2px}
.cap-details{flex:1}
.cap-title{font-family:var(–font-head);font-size:1rem;font-weight:700;color:var(–text);margin-bottom:12px}
.cap-row{display:flex;align-items:center;gap:10px;margin-bottom:8px}
.cap-row-lbl{font-size:0.8rem;color:var(–text2);width:80px;flex-shrink:0}
.cap-bar{flex:1;height:8px;background:var(–bg4);border-radius:4px;overflow:hidden}
.cap-bar-fill{height:100%;border-radius:4px;transition:width .5s ease}
.cap-row-num{font-family:var(–font-mono);font-size:0.82rem;font-weight:600;width:30px;text-align:right}
.cap-input-row{display:flex;align-items:center;gap:8px;margin-top:12px}
.cap-input-row label{font-size:0.78rem;color:var(–text3)}
.cap-input-row input{width:70px;background:var(–bg4);border:1px solid var(–border2);border-radius:6px;padding:5px 8px;color:var(–text);font-family:var(–font-mono);font-size:0.88rem;text-align:center;outline:none}
.cap-input-row input:focus{border-color:var(–teal)}
.cap-alarm{display:flex;align-items:center;gap:6px;font-size:0.78rem;padding:6px 12px;border-radius:6px;margin-top:8px;font-weight:600}

/* ═══════════════════════════════════════════════
SUMMARY / CHARTS
═══════════════════════════════════════════════ */
.sum-filter{display:flex;gap:12px;align-items:center;flex-wrap:wrap;margin-bottom:20px}
.sum-filter label{font-size:0.82rem;font-weight:700;color:var(–text2)}
.sum-filter select,.sum-filter input{
background:var(–bg2);border:1px solid var(–border2);border-radius:8px;
padding:7px 10px;color:var(–text);font-family:var(–font-body);font-size:0.85rem;outline:none;
}
.sum-filter select:focus,.sum-filter input:focus{border-color:var(–blue)}

.stats-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(150px,1fr));gap:12px;margin-bottom:20px}
.stat-card{
background:var(–bg2);border:1px solid var(–border);border-radius:var(–radius-lg);
padding:16px;display:flex;flex-direction:column;gap:6px;
position:relative;overflow:hidden;
}
.stat-card::after{
content:’’;position:absolute;top:-30px;right:-30px;
width:80px;height:80px;border-radius:50%;opacity:.06;background:currentColor;
}
.stat-card .sc-icon{font-size:1.4rem;line-height:1}
.stat-card .sc-num{font-family:var(–font-mono);font-size:1.8rem;font-weight:700;line-height:1}
.stat-card .sc-lbl{font-size:0.75rem;color:var(–text3)}
.stat-card .sc-sub{font-size:0.72rem;margin-top:2px;font-weight:600}

.charts-grid{display:grid;grid-template-columns:1fr 1fr;gap:16px;margin-bottom:20px}
.charts-grid.three{grid-template-columns:1fr 1fr 1fr}
.chart-card{background:var(–bg2);border:1px solid var(–border);border-radius:var(–radius-lg);padding:20px}
.chart-title{font-size:0.82rem;font-weight:700;color:var(–text2);margin-bottom:16px;display:flex;align-items:center;gap:8px}
.chart-wrap{position:relative;height:220px}

/* monthly table */
.sum-month-tbl{width:100%;border-collapse:collapse;font-size:0.82rem}
.sum-month-tbl th{padding:9px 12px;background:var(–bg4);color:var(–text2);text-align:center;font-family:var(–font-head);font-size:0.72rem;letter-spacing:.5px;border-bottom:1px solid var(–border)}
.sum-month-tbl td{padding:9px 12px;text-align:center;border-bottom:1px solid rgba(48,54,61,.5);color:var(–text)}
.sum-month-tbl tr:last-child td{background:var(–bg3);font-weight:700;color:var(–teal)}

/* pdf export notice */
.pdf-notice{background:var(–yellow-bg);border:1px solid var(–yellow-dim);border-radius:var(–radius);padding:12px 16px;font-size:0.82rem;color:var(–yellow);margin-bottom:16px;display:flex;align-items:center;gap:10px}

/* ═══════════════════════════════════════════════
MODAL
═══════════════════════════════════════════════ */
.modal-bg{
position:fixed;inset:0;background:rgba(0,0,0,.7);z-index:500;
display:none;align-items:center;justify-content:center;backdrop-filter:blur(4px);
}
.modal-bg.show{display:flex;animation:fadeIn .15s ease}
@keyframes fadeIn{from{opacity:0}to{opacity:1}}
.modal{
background:var(–bg2);border:1px solid var(–border2);
border-radius:var(–radius-lg);padding:28px 32px;
max-width:420px;width:90%;box-shadow:var(–shadow-lg);
}
.modal h3{font-family:var(–font-head);font-size:1.1rem;margin-bottom:8px}
.modal p{color:var(–text2);font-size:0.88rem;margin-bottom:20px}
.modal-btns{display:flex;gap:10px;justify-content:flex-end}

/* ═══════════════════════════════════════════════
TOAST
═══════════════════════════════════════════════ */
.toast{
position:fixed;bottom:24px;right:24px;z-index:600;
display:flex;align-items:center;gap:10px;
padding:12px 20px;border-radius:10px;font-size:0.88rem;font-weight:600;
box-shadow:var(–shadow);transform:translateY(80px);
transition:transform .3s cubic-bezier(.34,1.56,.64,1);pointer-events:none;
background:var(–bg3);border:1px solid var(–border2);color:var(–text);
}
.toast.show{transform:translateY(0)}
.toast.ok{border-color:var(–green-dim);background:var(–green-bg);color:var(–green)}
.toast.err{border-color:var(–red-dim);background:var(–red-bg);color:var(–red)}

/* ═══════════════════════════════════════════════
HOSXP PANEL
═══════════════════════════════════════════════ */
.hosxp-panel{
background:var(–bg3);border:1px solid var(–border2);
border-radius:var(–radius-lg);padding:20px;margin-bottom:16px;
display:none;
}
.hosxp-panel.show{display:block}
.hosxp-grid{display:grid;grid-template-columns:1fr 1fr 1fr;gap:12px;margin-bottom:12px}

/* ═══════════════════════════════════════════════
ENTRY PAGE — section forms
═══════════════════════════════════════════════ */
.section-selector{
display:grid;grid-template-columns:repeat(6,1fr);gap:10px;margin-bottom:20px;
}
.sec-btn{
display:flex;flex-direction:column;align-items:center;gap:6px;
padding:14px 8px;background:var(–bg2);border:1px solid var(–border);
border-radius:var(–radius-lg);cursor:pointer;transition:all .15s;
font-size:0.75rem;color:var(–text2);font-weight:600;font-family:var(–font-body);
}
.sec-btn:hover{background:var(–bg3);border-color:var(–border2);color:var(–text)}
.sec-btn.active{border-color:currentColor}
.sec-btn .sec-icon{font-size:1.6rem;line-height:1}
.sec-cold.active{color:var(–blue);background:var(–blue-bg)}
.sec-ev.active{color:var(–teal);background:var(–teal-bg)}
.sec-auto.active{color:var(–purple);background:var(–purple-bg)}
.sec-scene.active{color:var(–orange);background:var(–orange-bg)}
.sec-infant.active{color:var(–pink);background:var(–pink-bg)}
.sec-formalin.active{color:var(–yellow);background:var(–yellow-bg)}

@media(max-width:900px){
.section-selector{grid-template-columns:repeat(3,1fr)}
.charts-grid{grid-template-columns:1fr}
.charts-grid.three{grid-template-columns:1fr}
.cap-widget{flex-direction:column}
.hero-stats{display:none}
.sidebar{display:none}
}
</style>

</head>
<body>

<!-- TOPBAR -->

<div class="topbar">
  <div class="topbar-logo">FORENSIC<span>MANAGEMENT SYSTEM</span></div>
  <div class="topbar-divider"></div>
  <div class="topbar-info">
    <div>
      <div class="t-hosp">โรงพยาบาลกระบี่</div>
      <div class="t-dept">แผนกนิติเวช · Forensic Medicine Dept.</div>
    </div>
  </div>
  <div class="topbar-right">
    <div class="topbar-clock" id="topClock">--:--</div>
    <button class="topbar-hosxp" id="hosxpBtn" onclick="toggleHosXP()">⚡ HosXP Connect</button>
  </div>
</div>

<div class="layout">
<!-- SIDEBAR -->
<nav class="sidebar">
  <div class="sb-section">ภาพรวม</div>
  <button class="sb-item active" onclick="nav('entry')" data-p="entry">
    <span class="sb-icon">📋</span>บันทึกข้อมูล
  </button>

  <!-- Capacity widget in sidebar -->

  <div class="sb-capacity">
    <div class="sb-cap-title">🧊 ความจุห้องแช่</div>
    <div class="sb-cap-bar"><div class="sb-cap-fill" id="sbCapFill"></div></div>
    <div class="sb-cap-nums">
      <span id="sbCapUsed" style="color:var(--orange)">0 ใช้</span>
      <span id="sbCapFree" style="color:var(--green)">0 ว่าง</span>
      <span id="sbCapTotal" style="color:var(--text3)">0 ทั้งหมด</span>
    </div>
  </div>

  <div class="sb-section">ระบบงาน</div>
  <button class="sb-item" onclick="nav('cold')" data-p="cold">
    <span class="sb-icon">🧊</span>ห้องศพ
    <span class="sb-badge" id="b-cold">0</span>
  </button>
  <button class="sb-item" onclick="nav('evidence')" data-p="evidence">
    <span class="sb-icon">🔍</span>วัตถุพยาน
    <span class="sb-badge" id="b-ev">0</span>
  </button>
  <button class="sb-item" onclick="nav('autopsy')" data-p="autopsy">
    <span class="sb-icon">🔬</span>ผ่าศพ
    <span class="sb-badge" id="b-auto">0</span>
  </button>
  <button class="sb-item" onclick="nav('scene')" data-p="scene">
    <span class="sb-icon">🚨</span>ชันสูตรที่เกิดเหตุ
    <span class="sb-badge" id="b-scene">0</span>
  </button>
  <button class="sb-item" onclick="nav('infant')" data-p="infant">
    <span class="sb-icon">🍼</span>ศพทารก/อวัยวะ
    <span class="sb-badge" id="b-infant">0</span>
  </button>
  <button class="sb-item" onclick="nav('formalin')" data-p="formalin">
    <span class="sb-icon">💉</span>ฉีดฟอร์มาลีน
    <span class="sb-badge" id="b-formalin">0</span>
  </button>

  <div class="sb-section">รายงาน</div>
  <button class="sb-item" onclick="nav('summary')" data-p="summary">
    <span class="sb-icon">📊</span>สรุป &amp; กราฟ
  </button>

  <div style="margin-top:auto;padding:12px">
    <button class="btn btn-teal" style="width:100%;justify-content:center;font-size:0.82rem" onclick="exportAll()">
      ⬇️ Export CSV
    </button>
  </div>
</nav>

<!-- MAIN -->

<main class="main">

<!-- ══════════════════════════════════════════
  PAGE: บันทึกข้อมูล
══════════════════════════════════════════ -->

<div id="page-entry" class="page active">
  <div class="page-hero" style="background:linear-gradient(135deg,#0D1F3C 0%,#0A2A1E 100%);border:1px solid var(--blue-dim)">
    <div class="hero-icon" style="color:var(--teal)">📋</div>
    <div class="hero-text">
      <h1 style="color:var(--teal)">บันทึกข้อมูล</h1>
      <p>เลือกประเภทงาน → กรอกข้อมูล → กด ✅ บันทึก</p>
    </div>
    <div class="hero-stats">
      <div class="hero-stat">
        <div class="hs-num" style="color:var(--teal)" id="today-count">0</div>
        <div class="hs-lbl">บันทึกวันนี้</div>
      </div>
      <div class="hero-stat">
        <div class="hs-num" style="color:var(--blue)" id="total-count">0</div>
        <div class="hs-lbl">รวมทั้งหมด</div>
      </div>
    </div>
  </div>

  <!-- HosXP Panel -->

  <div class="hosxp-panel" id="hosxpPanel">
    <div class="card-title" style="color:var(--blue)"><span class="card-title-accent" style="background:var(--blue)"></span>⚡ HosXP Integration — กรอก HN เพื่อดึงข้อมูลผู้ป่วย</div>
    <div class="hosxp-grid">
      <div class="form-group">
        <label>HN (Hospital Number)</label>
        <input type="text" id="hn-input" placeholder="เช่น 123456" onkeydown="if(event.key==='Enter')fetchHN()">
      </div>
      <div class="form-group">
        <label>ชื่อ-นามสกุล (จาก HosXP)</label>
        <input type="text" id="hn-name" readonly placeholder="จะแสดงหลังค้นหา">
      </div>
      <div class="form-group">
        <label>วันเกิด / อายุ</label>
        <input type="text" id="hn-age" readonly placeholder="">
      </div>
    </div>
    <div style="display:flex;gap:8px;align-items:center">
      <button class="btn btn-primary btn-sm" onclick="fetchHN()">🔍 ดึงข้อมูล HosXP</button>
      <button class="btn btn-ghost btn-sm" onclick="fillFromHN()">📋 ใส่ลงฟอร์ม</button>
      <span id="hn-status" style="font-size:0.78rem;color:var(--text3)">ต้องเชื่อมต่อ HosXP API ก่อน</span>
    </div>
  </div>

  <!-- Section Selector -->

  <div class="section-selector">
    <button class="sec-btn sec-cold" onclick="setSection('cold')" data-sec="cold">
      <span class="sec-icon">🧊</span>ห้องศพ
    </button>
    <button class="sec-btn sec-ev" onclick="setSection('evidence')" data-sec="evidence">
      <span class="sec-icon">🔍</span>วัตถุพยาน
    </button>
    <button class="sec-btn sec-auto" onclick="setSection('autopsy')" data-sec="autopsy">
      <span class="sec-icon">🔬</span>ผ่าศพ
    </button>
    <button class="sec-btn sec-scene" onclick="setSection('scene')" data-sec="scene">
      <span class="sec-icon">🚨</span>ชันสูตร
    </button>
    <button class="sec-btn sec-infant" onclick="setSection('infant')" data-sec="infant">
      <span class="sec-icon">🍼</span>ทารก/อวัยวะ
    </button>
    <button class="sec-btn sec-formalin" onclick="setSection('formalin')" data-sec="formalin">
      <span class="sec-icon">💉</span>ฟอร์มาลีน
    </button>
  </div>

  <!-- ── FORM: ห้องศพ ── -->

  <div id="form-cold" class="card" style="display:none;border-color:var(--blue-dim)">
    <div class="card-title" style="color:var(--blue)">
      <span class="card-title-accent" style="background:var(--blue)"></span>
      🧊 ห้องศพ — กรอกข้อมูลฝากศพ
    </div>
    <div class="form-grid">
      <div class="form-group fg2"><label>ชื่อ-นามสกุล <span class="req">*</span></label>
        <input type="text" id="c_name" placeholder="ชื่อ-นามสกุลผู้เสียชีวิต" list="dl-names"></div>
      <div class="form-group"><label>เพศ <span class="req">*</span></label>
        <select id="c_gender"><option value="">เลือก</option><option>ชาย</option><option>หญิง</option><option>ไม่ทราบ</option></select></div>
      <div class="form-group"><label>อายุ (ปี)</label>
        <input type="number" id="c_age" placeholder="ปี" min="0" max="150"></div>
      <div class="form-group"><label>สัญชาติ</label>
        <select id="c_nation"><option value="">เลือก</option><option>ไทย</option><option>ต่างชาติ</option><option>ไม่ทราบ</option></select></div>
      <div class="form-group"><label>ตู้แช่หมายเลข</label>
        <input type="text" id="c_cab" placeholder="เช่น C-01" list="dl-cab"></div>
      <div class="form-group"><label>วันที่เริ่มฝาก <span class="req">*</span></label>
        <input type="date" id="c_din"></div>
      <div class="form-group"><label>เวลาเริ่มฝาก</label>
        <input type="time" id="c_tin"></div>
      <div class="form-group"><label>ค่าฝาก (บาท/วัน) <span class="req">*</span></label>
        <input type="number" id="c_rate" placeholder="0.00" min="0" step="0.01" oninput="calcCold()"></div>
      <div class="form-group"><label>วันที่รับศพ</label>
        <input type="date" id="c_dout" oninput="calcCold()">
        <div class="form-hint">กรอกภายหลังได้เมื่อรับศพ</div></div>
      <div class="form-group"><label>จำนวนวัน (อัตโนมัติ)</label>
        <input type="text" id="c_days" readonly></div>
      <div class="form-group"><label>ค่าใช้จ่ายรวม (อัตโนมัติ)</label>
        <input type="text" id="c_cost" readonly></div>
      <div class="form-group fg3"><label>หมายเหตุ</label>
        <textarea id="c_note" placeholder="ข้อมูลเพิ่มเติม"></textarea></div>
    </div>
  </div>

  <!-- ── FORM: วัตถุพยาน ── -->

  <div id="form-evidence" class="card" style="display:none;border-color:var(--teal-dim)">
    <div class="card-title" style="color:var(--teal)">
      <span class="card-title-accent" style="background:var(--teal)"></span>
      🔍 วัตถุพยาน
    </div>
    <div class="form-grid">
      <div class="form-group fg3"><label>รายละเอียดวัตถุพยาน <span class="req">*</span></label>
        <input type="text" id="e_desc" placeholder="ระบุชนิดและลักษณะของวัตถุพยาน"></div>
      <div class="form-group"><label>จำนวน (ชิ้น) <span class="req">*</span></label>
        <input type="number" id="e_qty" placeholder="0" min="1"></div>
      <div class="form-group"><label>แผนกที่ส่งมา <span class="req">*</span></label>
        <select id="e_dept"><option value="">เลือก</option><option>นิติเวช</option><option>ER</option><option>ศัลยกรรม</option><option>สูติ-นรีเวช</option><option>อายุรกรรม</option><option>กุมารเวช</option><option>อื่นๆ</option><option>ไม่ทราบ</option></select></div>
      <div class="form-group"><label>วันที่รับ <span class="req">*</span></label>
        <input type="date" id="e_din"></div>
      <div class="form-group fg2"><label>เจ้าหน้าที่ผู้รับ</label>
        <input type="text" id="e_recv" placeholder="ชื่อผู้รับ" list="dl-staff"></div>
      <div class="form-group"><label>วันที่มอบให้ พงส.</label>
        <input type="date" id="e_dout"></div>
      <div class="form-group fg2"><label>ชื่อพนักงานสอบสวน <span class="req">*</span></label>
        <input type="text" id="e_offi" placeholder="ชื่อ พงส." list="dl-offi"></div>
      <div class="form-group"><label>เบอร์ พงส.</label>
        <input type="tel" id="e_ph" placeholder="โทรศัพท์"></div>
      <div class="form-group"><label>สภ. <span class="req">*</span></label>
        <select id="e_stn"><option value="">เลือก</option><option>สภ.เมืองกระบี่</option><option>สภ.อ่าวลึก</option><option>สภ.เขาพนม</option><option>สภ.คลองท่อม</option><option>สภ.ปลายพระยา</option><option>สภ.เหนือคลอง</option><option>สภ.ลำทับ</option><option>สภ.เกาะลันตา</option><option>สภ.อื่นๆ</option><option>ไม่ทราบ</option></select></div>
      <div class="form-group fg3"><label>หมายเหตุ</label>
        <textarea id="e_note" placeholder="ข้อมูลเพิ่มเติม"></textarea></div>
    </div>
  </div>

  <!-- ── FORM: ผ่าศพ ── -->

  <div id="form-autopsy" class="card" style="display:none;border-color:var(--purple-dim)">
    <div class="card-title" style="color:var(--purple)">
      <span class="card-title-accent" style="background:var(--purple)"></span>
      🔬 ผ่าศพ (Autopsy)
    </div>
    <div class="form-grid">
      <div class="form-group"><label>F-Number <span class="req">*</span></label>
        <input type="text" id="a_fn" placeholder="F-001/2568" list="dl-fnum"></div>
      <div class="form-group fg2"><label>ชื่อ-นามสกุล <span class="req">*</span></label>
        <input type="text" id="a_name" placeholder="ชื่อ-นามสกุล"></div>
      <div class="form-group"><label>เพศ <span class="req">*</span></label>
        <select id="a_gender"><option value="">เลือก</option><option>ชาย</option><option>หญิง</option><option>ไม่ทราบ</option></select></div>
      <div class="form-group"><label>อายุ (ปี)</label>
        <input type="number" id="a_age" placeholder="ปี" min="0"></div>
      <div class="form-group"><label>สัญชาติ</label>
        <select id="a_nat"><option value="">เลือก</option><option>ไทย</option><option>ต่างชาติ</option><option>ไม่ทราบ</option></select></div>
      <div class="form-group"><label>สภ.</label>
        <select id="a_stn"><option value="">เลือก</option><option>สภ.เมืองกระบี่</option><option>สภ.อ่าวลึก</option><option>สภ.เขาพนม</option><option>สภ.คลองท่อม</option><option>สภ.ปลายพระยา</option><option>สภ.เหนือคลอง</option><option>สภ.ลำทับ</option><option>สภ.เกาะลันตา</option><option>สภ.อื่นๆ</option><option>ไม่ทราบ</option></select></div>
      <div class="form-group"><label>ต้นทาง</label>
        <select id="a_src"><option value="">เลือก</option><option>ส่งมาเอง</option><option>รพช.อ่าวลึก</option><option>รพช.เขาพนม</option><option>รพช.คลองท่อม</option><option>รพช.ปลายพระยา</option><option>รพช.เหนือคลอง</option><option>รพช.ลำทับ</option><option>รพช.เกาะลันตา</option><option>รพ.กระบี่</option><option>เคสออกชันสูตรเอง</option><option>อื่นๆ</option><option>ไม่ทราบ</option></select></div>
      <div class="form-group fg2"><label>ชื่อ รพช. / หน่วยงาน</label>
        <input type="text" id="a_hosp" placeholder="ชื่อสถานพยาบาล"></div>
      <div class="form-group"><label>วันที่รับศพ <span class="req">*</span></label>
        <input type="date" id="a_din"></div>
      <div class="form-group"><label>วันที่ผ่าศพ</label>
        <input type="date" id="a_daut"></div>
      <div class="form-group fg2"><label>แพทย์ผ่าศพ</label>
        <input type="text" id="a_doc" placeholder="ชื่อแพทย์" list="dl-doc"></div>
      <div class="form-group fg3"><label>สาเหตุการตาย (เบื้องต้น)</label>
        <input type="text" id="a_c1" placeholder="ระบุสาเหตุ"></div>
      <div class="form-group fg3"><label>สาเหตุการตาย (สรุป)</label>
        <input type="text" id="a_c2" placeholder="ระบุสาเหตุหลังผ่า"></div>
      <div class="form-group"><label>ส่งตรวจพิเศษ</label>
        <select id="a_sp"><option value="">เลือก</option><option>ใช่</option><option>ไม่ใช่</option><option>ไม่ทราบ</option></select></div>
      <div class="form-group fg2"><label>หมายเหตุ</label>
        <textarea id="a_note" placeholder="ข้อมูลเพิ่มเติม"></textarea></div>
    </div>
  </div>

  <!-- ── FORM: ชันสูตรที่เกิดเหตุ ── -->

  <div id="form-scene" class="card" style="display:none;border-color:var(--orange-dim)">
    <div class="card-title" style="color:var(--orange)">
      <span class="card-title-accent" style="background:var(--orange)"></span>
      🚨 ชันสูตรที่เกิดเหตุ
    </div>
    <div class="form-grid">
      <div class="form-group"><label>วันที่ <span class="req">*</span></label>
        <input type="date" id="s_dt"></div>
      <div class="form-group"><label>เวลา</label>
        <input type="time" id="s_tm"></div>
      <div class="form-group fg2"><label>ชื่อ-นามสกุล <span class="req">*</span></label>
        <input type="text" id="s_name" placeholder="ชื่อ-นามสกุลผู้เสียชีวิต"></div>
      <div class="form-group"><label>เพศ</label>
        <select id="s_gen"><option value="">เลือก</option><option>ชาย</option><option>หญิง</option><option>ไม่ทราบ</option></select></div>
      <div class="form-group fg3"><label>สถานที่เกิดเหตุ <span class="req">*</span></label>
        <input type="text" id="s_loc" placeholder="ระบุสถานที่"></div>
      <div class="form-group"><label>สภ. <span class="req">*</span></label>
        <select id="s_stn"><option value="">เลือก</option><option>สภ.เมืองกระบี่</option><option>สภ.อ่าวลึก</option><option>สภ.เขาพนม</option><option>สภ.คลองท่อม</option><option>สภ.ปลายพระยา</option><option>สภ.เหนือคลอง</option><option>สภ.ลำทับ</option><option>สภ.เกาะลันตา</option><option>สภ.อื่นๆ</option><option>ไม่ทราบ</option></select></div>
      <div class="form-group fg2"><label>ชื่อ พงส. <span class="req">*</span></label>
        <input type="text" id="s_offi" placeholder="ชื่อพนักงานสอบสวน" list="dl-offi2"></div>
      <div class="form-group"><label>เบอร์ พงส.</label>
        <input type="tel" id="s_ph" placeholder="โทรศัพท์"></div>
      <div class="form-group fg2"><label>เจ้าหน้าที่ที่ออก</label>
        <input type="text" id="s_stf" placeholder="ชื่อเจ้าหน้าที่" list="dl-stf"></div>
      <div class="form-group fg2"><label>แพทย์ที่ออก</label>
        <input type="text" id="s_doc" placeholder="ชื่อแพทย์" list="dl-doc2"></div>
      <div class="form-group"><label>ผลดำเนินการ <span class="req">*</span></label>
        <select id="s_res" onchange="sceneSubToggle()">
          <option value="">เลือก</option><option>นำเข้าผ่าศพ</option><option>มอบคืนญาติ</option><option>ไม่ทราบ</option>
        </select></div>
      <div class="form-group" id="sg1" style="display:none"><label>ฝากแช่ศพ</label>
        <select id="s_cold"><option value="">เลือก</option><option>ใช่</option><option>ไม่ใช่</option></select></div>
      <div class="form-group" id="sg2" style="display:none"><label>วันที่มอบคืนญาติ</label>
        <input type="date" id="s_retdt"></div>
      <div class="form-group fg3"><label>หมายเหตุ</label>
        <textarea id="s_note" placeholder="ข้อมูลเพิ่มเติม"></textarea></div>
    </div>
  </div>

  <!-- ── FORM: ศพทารก/อวัยวะ ── -->

  <div id="form-infant" class="card" style="display:none;border-color:var(--pink-dim)">
    <div class="card-title" style="color:var(--pink)">
      <span class="card-title-accent" style="background:var(--pink)"></span>
      🍼 ศพทารกและชิ้นส่วนอวัยวะ
    </div>
    <!-- Sub-type toggle -->
    <div class="seg-tabs" style="max-width:400px">
      <button class="seg-tab active" id="infant-tab-infant" onclick="infantSubSwitch('infant')">👶 ศพทารก</button>
      <button class="seg-tab" id="infant-tab-organ" onclick="infantSubSwitch('organ')">🫀 ชิ้นส่วนอวัยวะ</button>
    </div>

```
<!-- Infant sub-form -->
<div id="isub-infant">
  <div class="form-grid">
    <div class="form-group fg3"><label>ชื่อ (บุตรนาง...) <span class="req">*</span></label>
      <input type="text" id="inf_name" placeholder="เช่น บุตรนางสมหญิง ใจดี"></div>
    <div class="form-group"><label>เพศทารก</label>
      <select id="inf_gen"><option value="">เลือก</option><option>ชาย</option><option>หญิง</option><option>ไม่ทราบ</option></select></div>
    <div class="form-group"><label>น้ำหนัก (กรัม)</label>
      <input type="number" id="inf_wt" placeholder="กรัม" min="0"></div>
    <div class="form-group"><label>อายุครรภ์ (สัปดาห์)</label>
      <input type="number" id="inf_ga" placeholder="สัปดาห์" min="0" max="45"></div>
    <div class="form-group"><label>วันที่ฝาก <span class="req">*</span></label>
      <input type="date" id="inf_din"></div>
    <div class="form-group"><label>แผนกที่ส่งมา</label>
      <select id="inf_dept"><option value="">เลือก</option><option>สูติ-นรีเวช</option><option>ห้องคลอด</option><option>NICU</option><option>ER</option><option>นิติเวช</option><option>อื่นๆ</option></select></div>
    <div class="form-group fg2"><label>ชื่อมารดา</label>
      <input type="text" id="inf_mother" placeholder="ชื่อ-นามสกุลมารดา"></div>
    <div class="form-group"><label>วันที่ส่งฝัง</label>
      <input type="date" id="inf_bury">
      <div class="form-hint">กรอกเมื่อส่งฝังแล้ว</div></div>
    <div class="toggle-group fg2">
      <input type="checkbox" class="toggle-check" id="inf_buried">
      <label for="inf_buried">✅ ส่งฝังแล้ว</label>
    </div>
    <div class="form-group fg3"><label>หมายเหตุ</label>
      <textarea id="inf_note" placeholder="ข้อมูลเพิ่มเติม"></textarea></div>
  </div>
</div>

<!-- Organ sub-form -->
<div id="isub-organ" style="display:none">
  <div class="form-grid">
    <div class="form-group fg2"><label>ชนิดอวัยวะ / ชิ้นส่วน <span class="req">*</span></label>
      <input type="text" id="org_type" placeholder="เช่น ตับ, ไต, ชิ้นส่วนกระดูก"></div>
    <div class="form-group"><label>จำนวน (ชิ้น) <span class="req">*</span></label>
      <input type="number" id="org_qty" placeholder="0" min="1"></div>
    <div class="form-group"><label>วันที่ฝาก <span class="req">*</span></label>
      <input type="date" id="org_din"></div>
    <div class="form-group"><label>แผนกที่ฝาก</label>
      <select id="org_dept"><option value="">เลือก</option><option>นิติเวช</option><option>ศัลยกรรม</option><option>ออร์โธ</option><option>สูติ-นรีเวช</option><option>ER</option><option>อื่นๆ</option></select></div>
    <div class="form-group fg2"><label>มาจากเคส / ผู้ป่วย</label>
      <input type="text" id="org_case" placeholder="ชื่อผู้ป่วย หรือ HN"></div>
    <div class="form-group"><label>วันที่ส่งฝัง</label>
      <input type="date" id="org_bury">
      <div class="form-hint">กรอกเมื่อส่งฝังแล้ว</div></div>
    <div class="toggle-group fg2">
      <input type="checkbox" class="toggle-check" id="org_buried">
      <label for="org_buried">✅ ส่งฝังแล้ว</label>
    </div>
    <div class="form-group fg3"><label>หมายเหตุ</label>
      <textarea id="org_note" placeholder="ข้อมูลเพิ่มเติม"></textarea></div>
  </div>
</div>
```

  </div>

  <!-- ── FORM: ฉีดฟอร์มาลีน ── -->

  <div id="form-formalin" class="card" style="display:none;border-color:var(--yellow-dim)">
    <div class="card-title" style="color:var(--yellow)">
      <span class="card-title-accent" style="background:var(--yellow)"></span>
      💉 บริการฉีดฟอร์มาลีน
    </div>
    <div class="form-grid">
      <div class="form-group"><label>วันที่ <span class="req">*</span></label>
        <input type="date" id="f_dt"></div>
      <div class="form-group fg2"><label>ชื่อ-นามสกุล <span class="req">*</span></label>
        <input type="text" id="f_name" placeholder="ชื่อ-นามสกุลผู้เสียชีวิต"></div>
      <div class="form-group"><label>อายุ (ปี)</label>
        <input type="number" id="f_age" placeholder="ปี" min="0"></div>
      <div class="form-group"><label>เพศ</label>
        <select id="f_gen"><option value="">เลือก</option><option>ชาย</option><option>หญิง</option><option>ไม่ทราบ</option></select></div>
      <div class="form-group"><label>ค่าใช้จ่าย (บาท) <span class="req">*</span></label>
        <input type="number" id="f_cost" placeholder="0.00" min="0" step="0.01"></div>
      <div class="form-group fg2"><label>เจ้าหน้าที่ที่ฉีด</label>
        <input type="text" id="f_staff" placeholder="ชื่อเจ้าหน้าที่" list="dl-staff2"></div>
      <div class="toggle-group">
        <input type="checkbox" class="toggle-check" id="f_paid">
        <label for="f_paid">💳 ชำระเงินแล้ว</label>
      </div>
      <div class="toggle-group">
        <input type="checkbox" class="toggle-check" id="f_taken" onchange="formalinRetToggle()">
        <label for="f_taken">🚪 รับศพแล้ว</label>
      </div>
      <div class="form-group" id="f_ret_grp" style="display:none"><label>วันที่รับศพ</label>
        <input type="date" id="f_retdt"></div>
      <div class="form-group fg3"><label>หมายเหตุ</label>
        <textarea id="f_note" placeholder="ข้อมูลเพิ่มเติม"></textarea></div>
    </div>
  </div>

  <!-- Buttons -->

  <div id="entry-btns" class="btn-row" style="display:none">
    <button class="btn btn-primary" id="btnSave" onclick="saveRec()">✅ บันทึกข้อมูล</button>
    <button class="btn btn-ghost" onclick="clearForm()">🗑 ล้างข้อมูล</button>
    <div class="edit-indicator" id="editInd">✏️ กำลังแก้ไข</div>
    <button class="btn btn-warning btn-sm" id="btnCancel" style="display:none" onclick="cancelEdit()">✖ ยกเลิกแก้ไข</button>
  </div>
</div>

<!-- ══════════════════════════════════════════
  PAGES: Data tables (cold, evidence, autopsy, scene, infant, formalin)
══════════════════════════════════════════ -->

<div id="page-cold" class="page">
  <div class="page-hero" style="background:linear-gradient(135deg,var(--blue-bg) 0%,#071830 100%);border:1px solid var(--blue-dim)">
    <div class="hero-icon" style="color:var(--blue)">🧊</div>
    <div class="hero-text" style="color:var(--blue)"><h1>ห้องศพ</h1><p>ระบบจัดการฝากศพในตู้แช่</p></div>
    <div class="hero-stats">
      <div class="hero-stat"><div class="hs-num" id="cold-active" style="color:var(--orange)">0</div><div class="hs-lbl">ยังอยู่</div></div>
      <div class="hero-stat"><div class="hs-num" id="cold-done" style="color:var(--green)">0</div><div class="hs-lbl">รับแล้ว</div></div>
    </div>
  </div>
  <!-- Capacity Widget -->
  <div class="cap-widget">
    <div class="cap-donut-wrap"><canvas id="capDonut"></canvas>
      <div class="cap-donut-center">
        <div class="cap-donut-num" id="capPct" style="color:var(--orange)">0%</div>
        <div class="cap-donut-lbl">ใช้งาน</div>
      </div>
    </div>
    <div class="cap-details">
      <div class="cap-title">🧊 ความจุห้องแช่ศพ — อัพเดท Real-time</div>
      <div class="cap-row">
        <div class="cap-row-lbl" style="color:var(--orange)">ใช้อยู่</div>
        <div class="cap-bar"><div class="cap-bar-fill" id="cBarUsed" style="background:var(--orange)"></div></div>
        <div class="cap-row-num" id="cNumUsed" style="color:var(--orange)">0</div>
      </div>
      <div class="cap-row">
        <div class="cap-row-lbl" style="color:var(--green)">ว่าง</div>
        <div class="cap-bar"><div class="cap-bar-fill" id="cBarFree" style="background:var(--green)"></div></div>
        <div class="cap-row-num" id="cNumFree" style="color:var(--green)">0</div>
      </div>
      <div class="cap-input-row">
        <label>ความจุทั้งหมด:</label>
        <input type="number" id="capTotal" value="20" min="1" max="200" oninput="saveCapacity();updateCapacity()">
        <span style="font-size:0.78rem;color:var(--text3)">ช่อง</span>
      </div>
      <div id="capAlarm" class="cap-alarm" style="display:none"></div>
    </div>
  </div>
  <div class="search-row">
    <input type="text" placeholder="🔍 ค้นหาชื่อ, ตู้แช่, สถานะ..." oninput="renderTbl('cold',this.value)" id="sq-cold">
    <button class="btn btn-primary btn-sm" onclick="nav('entry');setSection('cold')">+ เพิ่มรายการ</button>
    <span class="rec-count" id="rc-cold"></span>
  </div>
  <div class="card" style="padding:0"><div class="tbl-wrap" id="tbl-cold"></div></div>
</div>

<div id="page-evidence" class="page">
  <div class="page-hero" style="background:linear-gradient(135deg,var(--teal-bg) 0%,#030E0C 100%);border:1px solid var(--teal-dim)">
    <div class="hero-icon" style="color:var(--teal)">🔍</div>
    <div class="hero-text" style="color:var(--teal)"><h1>วัตถุพยาน</h1><p>ระบบเก็บรักษาวัตถุพยาน</p></div>
  </div>
  <div class="search-row">
    <input type="text" placeholder="🔍 ค้นหา..." oninput="renderTbl('evidence',this.value)" id="sq-ev">
    <button class="btn btn-teal btn-sm" onclick="nav('entry');setSection('evidence')">+ เพิ่มรายการ</button>
    <span class="rec-count" id="rc-ev"></span>
  </div>
  <div class="card" style="padding:0"><div class="tbl-wrap" id="tbl-evidence"></div></div>
</div>

<div id="page-autopsy" class="page">
  <div class="page-hero" style="background:linear-gradient(135deg,var(--purple-bg) 0%,#0A0520 100%);border:1px solid var(--purple-dim)">
    <div class="hero-icon" style="color:var(--purple)">🔬</div>
    <div class="hero-text" style="color:var(--purple)"><h1>ผ่าศพ (Autopsy)</h1><p>บันทึกเคสการชันสูตรพลิกศพ</p></div>
  </div>
  <div class="search-row">
    <input type="text" placeholder="🔍 ค้นหา F-Number, ชื่อ..." oninput="renderTbl('autopsy',this.value)" id="sq-auto">
    <button class="btn btn-sm" style="background:var(--purple);color:white" onclick="nav('entry');setSection('autopsy')">+ เพิ่มรายการ</button>
    <span class="rec-count" id="rc-auto"></span>
  </div>
  <div class="card" style="padding:0"><div class="tbl-wrap" id="tbl-autopsy"></div></div>
</div>

<div id="page-scene" class="page">
  <div class="page-hero" style="background:linear-gradient(135deg,var(--orange-bg) 0%,#150800 100%);border:1px solid var(--orange-dim)">
    <div class="hero-icon" style="color:var(--orange)">🚨</div>
    <div class="hero-text" style="color:var(--orange)"><h1>ชันสูตรที่เกิดเหตุ</h1><p>บันทึกการออกชันสูตร ณ สถานที่เกิดเหตุ</p></div>
  </div>
  <div class="search-row">
    <input type="text" placeholder="🔍 ค้นหาชื่อ, สถานที่, สภ..." oninput="renderTbl('scene',this.value)" id="sq-sc">
    <button class="btn btn-sm" style="background:var(--orange);color:white" onclick="nav('entry');setSection('scene')">+ เพิ่มรายการ</button>
    <span class="rec-count" id="rc-sc"></span>
  </div>
  <div class="card" style="padding:0"><div class="tbl-wrap" id="tbl-scene"></div></div>
</div>

<div id="page-infant" class="page">
  <div class="page-hero" style="background:linear-gradient(135deg,var(--pink-bg) 0%,#150510 100%);border:1px solid var(--pink-dim)">
    <div class="hero-icon" style="color:var(--pink)">🍼</div>
    <div class="hero-text" style="color:var(--pink)"><h1>ศพทารกและชิ้นส่วนอวัยวะ</h1><p>ระบบบันทึกและติดตามการส่งฝัง</p></div>
  </div>
  <div class="search-row">
    <input type="text" placeholder="🔍 ค้นหา..." oninput="renderTbl('infant',this.value)" id="sq-inf">
    <button class="btn btn-sm" style="background:var(--pink);color:var(--bg)" onclick="nav('entry');setSection('infant')">+ เพิ่มรายการ</button>
    <span class="rec-count" id="rc-inf"></span>
  </div>
  <div class="card" style="padding:0"><div class="tbl-wrap" id="tbl-infant"></div></div>
</div>

<div id="page-formalin" class="page">
  <div class="page-hero" style="background:linear-gradient(135deg,var(--yellow-bg) 0%,#120A00 100%);border:1px solid var(--yellow-dim)">
    <div class="hero-icon" style="color:var(--yellow)">💉</div>
    <div class="hero-text" style="color:var(--yellow)"><h1>บริการฉีดฟอร์มาลีน</h1><p>บันทึกการให้บริการและการชำระเงิน</p></div>
  </div>
  <div class="search-row">
    <input type="text" placeholder="🔍 ค้นหาชื่อ, เจ้าหน้าที่..." oninput="renderTbl('formalin',this.value)" id="sq-fml">
    <button class="btn btn-sm" style="background:var(--yellow);color:var(--bg)" onclick="nav('entry');setSection('formalin')">+ เพิ่มรายการ</button>
    <span class="rec-count" id="rc-fml"></span>
  </div>
  <div class="card" style="padding:0"><div class="tbl-wrap" id="tbl-formalin"></div></div>
</div>

<!-- ══════════════════════════════════════════
  PAGE: สรุป & กราฟ
══════════════════════════════════════════ -->

<div id="page-summary" class="page">
  <div class="page-hero" style="background:linear-gradient(135deg,#0A0F16 0%,#111827 100%);border:1px solid var(--border2)">
    <div class="hero-icon" style="color:var(--yellow)">📊</div>
    <div class="hero-text"><h1 style="color:var(--yellow)">สรุปข้อมูลและกราฟสถิติ</h1><p>ภาพรวมระบบงานนิติเวช — อัพเดท Real-time</p></div>
  </div>

  <div class="pdf-notice">
    📄 <span>Export PDF: กด <b>Ctrl+P</b> แล้วเลือก "Save as PDF" หรือกดปุ่ม Export ด้านล่าง (ใช้ Browser Print)</span>
    <button class="btn btn-warning btn-sm" style="margin-left:auto" onclick="printReport()">🖨 Export PDF</button>
  </div>

  <div class="sum-filter card">
    <label>📅 เดือน:</label>
    <select id="sm_mo" onchange="renderSummary()">
      <option value="0">ทุกเดือน</option>
      <option value="1">มกราคม</option><option value="2">กุมภาพันธ์</option>
      <option value="3">มีนาคม</option><option value="4">เมษายน</option>
      <option value="5">พฤษภาคม</option><option value="6">มิถุนายน</option>
      <option value="7">กรกฎาคม</option><option value="8">สิงหาคม</option>
      <option value="9">กันยายน</option><option value="10">ตุลาคม</option>
      <option value="11">พฤศจิกายน</option><option value="12">ธันวาคม</option>
    </select>
    <label>ปี (พ.ศ.):</label>
    <input type="number" id="sm_yr" value="2568" min="2560" max="2590" style="width:90px" onchange="renderSummary()">
  </div>

  <div class="stats-grid" id="sum-stats"></div>
  <div class="charts-grid" id="sum-charts-top"></div>
  <div class="charts-grid three" id="sum-charts-mid"></div>
  <div class="card" id="sum-monthly-card">
    <div class="card-title"><span class="card-title-accent" style="background:var(--teal)"></span>📈 ตารางสรุปรายเดือน</div>
    <div class="tbl-wrap"><table class="sum-month-tbl" id="sum-month-tbl"></table></div>
  </div>
</div>

</main>
</div>

<!-- Modal -->

<div class="modal-bg" id="mdl">
  <div class="modal">
    <h3 id="mdl-title">⚠️ ยืนยันการลบ</h3>
    <p id="mdl-msg">ต้องการลบรายการนี้ใช่หรือไม่?</p>
    <div class="modal-btns">
      <button class="btn btn-ghost" onclick="closeMdl()">ยกเลิก</button>
      <button class="btn btn-danger" id="mdl-ok">🗑 ลบ</button>
    </div>
  </div>
</div>
<!-- Datalists -->
<datalist id="dl-names"></datalist>
<datalist id="dl-cab"></datalist>
<datalist id="dl-staff"></datalist>
<datalist id="dl-staff2"></datalist>
<datalist id="dl-offi"></datalist>
<datalist id="dl-offi2"></datalist>
<datalist id="dl-doc"></datalist>
<datalist id="dl-doc2"></datalist>
<datalist id="dl-stf"></datalist>
<datalist id="dl-fnum"></datalist>
<!-- Toast -->
<div class="toast" id="toast"></div>
<script>
// ════════════════════════════════════════════════════════════════
// FORENSIC SYSTEM v2 — JavaScript
// ════════════════════════════════════════════════════════════════

// ── DATA STORE ──────────────────────────────────────────────────
const DB_KEYS = {
cold:‘fm2_cold’, evidence:‘fm2_ev’, autopsy:‘fm2_auto’,
scene:‘fm2_scene’, infant:‘fm2_infant’, formalin:‘fm2_formalin’,
capacity:‘fm2_cap’
};
let DB = {};
let CAP = 20; // default capacity

function loadDB(){
for(let k in DB_KEYS) DB[k] = JSON.parse(localStorage.getItem(DB_KEYS[k])||’[]’);
CAP = parseInt(localStorage.getItem(DB_KEYS.capacity)||‘20’);
document.getElementById(‘capTotal’).value = CAP;
}
function saveDB(type){ localStorage.setItem(DB_KEYS[type], JSON.stringify(DB[type])); }
function saveCapacity(){
CAP = parseInt(document.getElementById(‘capTotal’).value)||20;
localStorage.setItem(DB_KEYS.capacity, CAP);
}

// ── NAVIGATION ──────────────────────────────────────────────────
function nav(name){
document.querySelectorAll(’.page’).forEach(p=>p.classList.remove(‘active’));
document.querySelectorAll(’.sb-item’).forEach(b=>b.classList.remove(‘active’));
const pg = document.getElementById(‘page-’+name);
if(pg) pg.classList.add(‘active’);
const btn = document.querySelector(`[data-p="${name}"]`);
if(btn) btn.classList.add(‘active’);
if(name===‘cold’) renderTbl(‘cold’,’’),updateCapacity();
else if(name!==‘entry’ && name!==‘summary’) renderTbl(name,’’);
if(name===‘summary’) renderSummary();
}

// ── SECTION SWITCHER ────────────────────────────────────────────
let curSec = ‘’;
let editId = null;
let infantSub = ‘infant’;

function setSection(sec){
curSec = sec;
const forms=[‘cold’,‘evidence’,‘autopsy’,‘scene’,‘infant’,‘formalin’];
forms.forEach(f=> document.getElementById(‘form-’+f).style.display = f===sec?‘block’:‘none’);
document.getElementById(‘entry-btns’).style.display = ‘flex’;
document.querySelectorAll(’.sec-btn’).forEach(b=>b.classList.remove(‘active’));
const btn = document.querySelector(`[data-sec="${sec}"]`);
if(btn) btn.classList.add(‘active’);
editId=null; resetBtnState();
}

function infantSubSwitch(sub){
infantSub = sub;
document.getElementById(‘isub-infant’).style.display = sub===‘infant’?‘block’:‘none’;
document.getElementById(‘isub-organ’).style.display  = sub===‘organ’?‘block’:‘none’;
document.getElementById(‘infant-tab-infant’).classList.toggle(‘active’, sub===‘infant’);
document.getElementById(‘infant-tab-organ’).classList.toggle(‘active’, sub===‘organ’);
}

function sceneSubToggle(){
const v = document.getElementById(‘s_res’).value;
document.getElementById(‘sg1’).style.display = v===‘มอบคืนญาติ’?‘block’:‘none’;
document.getElementById(‘sg2’).style.display = v===‘มอบคืนญาติ’?‘block’:‘none’;
}

function formalinRetToggle(){
const checked = document.getElementById(‘f_taken’).checked;
document.getElementById(‘f_ret_grp’).style.display = checked?‘block’:‘none’;
}

// ── AUTO-CALCULATE COLD COST ─────────────────────────────────────
function calcCold(){
const d1=document.getElementById(‘c_din’).value;
const d2=document.getElementById(‘c_dout’).value;
const r=parseFloat(document.getElementById(‘c_rate’).value)||0;
if(d1 && d2){
const days=Math.max(0,Math.round((new Date(d2)-new Date(d1))/86400000));
document.getElementById(‘c_days’).value = days+’ วัน’;
document.getElementById(‘c_cost’).value = (days*r).toLocaleString(‘th-TH’,{minimumFractionDigits:2})+’ บาท’;
} else {
document.getElementById(‘c_days’).value=’’;
document.getElementById(‘c_cost’).value=’’;
}
}
[‘c_din’,‘c_dout’,‘c_rate’].forEach(id=>{
document.getElementById(id)?.addEventListener(‘input’,calcCold);
});

// ── SAVE ────────────────────────────────────────────────────────
function gv(id){ return (document.getElementById(id)?.value||’’).trim(); }
function gc(id){ return document.getElementById(id)?.checked||false; }

function saveRec(){
if(!curSec){ toast(‘กรุณาเลือกประเภทงานก่อน’,‘err’); return; }
let rec=null;
if(curSec===‘cold’)     rec=buildCold();
if(curSec===‘evidence’) rec=buildEv();
if(curSec===‘autopsy’)  rec=buildAuto();
if(curSec===‘scene’)    rec=buildScene();
if(curSec===‘infant’)   rec=buildInfant();
if(curSec===‘formalin’) rec=buildFormalin();
if(!rec) return;

if(editId!==null){
const idx=DB[curSec].findIndex(r=>r.id===editId);
if(idx>=0){ rec.id=editId; rec.createdAt=DB[curSec][idx].createdAt; rec.updatedAt=now(); DB[curSec][idx]=rec; }
toast(‘✅ อัพเดทข้อมูลเรียบร้อย’,‘ok’);
} else {
rec.id=uid(); rec.createdAt=now();
DB[curSec].push(rec);
toast(‘✅ บันทึกข้อมูลเรียบร้อย’,‘ok’);
}
saveDB(curSec); updateBadges(); updateAutocomplete(); updateCapacity();
updateTodayCount(); clearForm();
}

function buildCold(){
if(!gv(‘c_name’)){toast(‘กรุณากรอกชื่อ-นามสกุล’,‘err’);return null;}
if(!gv(‘c_din’)){toast(‘กรุณาระบุวันที่เริ่มฝาก’,‘err’);return null;}
if(!gv(‘c_rate’)){toast(‘กรุณาระบุค่าฝาก/วัน’,‘err’);return null;}
const d1=gv(‘c_din’),d2=gv(‘c_dout’),r=parseFloat(gv(‘c_rate’))||0;
let days=0,cost=0;
if(d1&&d2){days=Math.max(0,Math.round((new Date(d2)-new Date(d1))/86400000));cost=days*r;}
return{name:gv(‘c_name’),gender:gv(‘c_gender’),age:gv(‘c_age’),nation:gv(‘c_nation’),
cabinet:gv(‘c_cab’),dateIn:d1,timeIn:gv(‘c_tin’),rate:r,dateOut:d2,
days,cost,status:d2?‘รับศพแล้ว’:‘ยังอยู่’,note:gv(‘c_note’)};
}
function buildEv(){
if(!gv(‘e_desc’)){toast(‘กรุณากรอกรายละเอียด’,‘err’);return null;}
if(!gv(‘e_din’)){toast(‘กรุณาระบุวันที่รับ’,‘err’);return null;}
return{desc:gv(‘e_desc’),qty:gv(‘e_qty’),dept:gv(‘e_dept’),dateIn:gv(‘e_din’),
receiver:gv(‘e_recv’),dateOut:gv(‘e_dout’),officer:gv(‘e_offi’),
phone:gv(‘e_ph’),station:gv(‘e_stn’),note:gv(‘e_note’),
status:gv(‘e_dout’)?‘มอบแล้ว’:‘รอมอบ’};
}
function buildAuto(){
if(!gv(‘a_name’)){toast(‘กรุณากรอกชื่อ-นามสกุล’,‘err’);return null;}
if(!gv(‘a_din’)){toast(‘กรุณาระบุวันที่รับ’,‘err’);return null;}
return{fnum:gv(‘a_fn’),name:gv(‘a_name’),gender:gv(‘a_gender’),age:gv(‘a_age’),
nation:gv(‘a_nat’),station:gv(‘a_stn’),source:gv(‘a_src’),hospital:gv(‘a_hosp’),
dateIn:gv(‘a_din’),dateAuto:gv(‘a_daut’),doctor:gv(‘a_doc’),
cause1:gv(‘a_c1’),cause2:gv(‘a_c2’),special:gv(‘a_sp’),note:gv(‘a_note’)};
}
function buildScene(){
if(!gv(‘s_name’)){toast(‘กรุณากรอกชื่อ-นามสกุล’,‘err’);return null;}
if(!gv(‘s_dt’)){toast(‘กรุณาระบุวันที่’,‘err’);return null;}
return{date:gv(‘s_dt’),time:gv(‘s_tm’),name:gv(‘s_name’),gender:gv(‘s_gen’),
location:gv(‘s_loc’),station:gv(‘s_stn’),officer:gv(‘s_offi’),
phone:gv(‘s_ph’),staff:gv(‘s_stf’),doctor:gv(‘s_doc’),
result:gv(‘s_res’),cold:gv(‘s_cold’),retdate:gv(‘s_retdt’),note:gv(‘s_note’)};
}
function buildInfant(){
if(infantSub===‘infant’){
if(!gv(‘inf_name’)){toast(‘กรุณากรอกชื่อทารก’,‘err’);return null;}
return{subtype:‘ศพทารก’,name:gv(‘inf_name’),gender:gv(‘inf_gen’),
weight:gv(‘inf_wt’),ga:gv(‘inf_ga’),dateIn:gv(‘inf_din’),dept:gv(‘inf_dept’),
mother:gv(‘inf_mother’),buried:gc(‘inf_buried’),buryDate:gv(‘inf_bury’),note:gv(‘inf_note’)};
} else {
if(!gv(‘org_type’)){toast(‘กรุณากรอกชนิดอวัยวะ’,‘err’);return null;}
return{subtype:‘อวัยวะ’,orgType:gv(‘org_type’),qty:gv(‘org_qty’),dateIn:gv(‘org_din’),
dept:gv(‘org_dept’),caseName:gv(‘org_case’),buried:gc(‘org_buried’),buryDate:gv(‘org_bury’),note:gv(‘org_note’)};
}
}
function buildFormalin(){
if(!gv(‘f_name’)){toast(‘กรุณากรอกชื่อ-นามสกุล’,‘err’);return null;}
if(!gv(‘f_dt’)){toast(‘กรุณาระบุวันที่’,‘err’);return null;}
return{date:gv(‘f_dt’),name:gv(‘f_name’),age:gv(‘f_age’),gender:gv(‘f_gen’),
cost:parseFloat(gv(‘f_cost’))||0,staff:gv(‘f_staff’),
paid:gc(‘f_paid’),taken:gc(‘f_taken’),retdate:gv(‘f_retdt’),note:gv(‘f_note’)};
}

// ── CLEAR / CANCEL ───────────────────────────────────────────────
function clearForm(){
const allInputs=[‘c_name’,‘c_gender’,‘c_age’,‘c_nation’,‘c_cab’,‘c_din’,‘c_tin’,‘c_rate’,‘c_dout’,‘c_days’,‘c_cost’,‘c_note’,
‘e_desc’,‘e_qty’,‘e_dept’,‘e_din’,‘e_recv’,‘e_dout’,‘e_offi’,‘e_ph’,‘e_stn’,‘e_note’,
‘a_fn’,‘a_name’,‘a_gender’,‘a_age’,‘a_nat’,‘a_stn’,‘a_src’,‘a_hosp’,‘a_din’,‘a_daut’,‘a_doc’,‘a_c1’,‘a_c2’,‘a_sp’,‘a_note’,
‘s_dt’,‘s_tm’,‘s_name’,‘s_gen’,‘s_loc’,‘s_stn’,‘s_offi’,‘s_ph’,‘s_stf’,‘s_doc’,‘s_res’,‘s_cold’,‘s_retdt’,‘s_note’,
‘inf_name’,‘inf_gen’,‘inf_wt’,‘inf_ga’,‘inf_din’,‘inf_dept’,‘inf_mother’,‘inf_bury’,‘inf_note’,
‘org_type’,‘org_qty’,‘org_din’,‘org_dept’,‘org_case’,‘org_bury’,‘org_note’,
‘f_dt’,‘f_name’,‘f_age’,‘f_gen’,‘f_cost’,‘f_staff’,‘f_retdt’,‘f_note’];
allInputs.forEach(id=>{ const el=document.getElementById(id); if(el) el.value=’’; });
[‘inf_buried’,‘org_buried’,‘f_paid’,‘f_taken’].forEach(id=>{
const el=document.getElementById(id); if(el) el.checked=false;
});
editId=null; resetBtnState();
document.getElementById(‘f_ret_grp’).style.display=‘none’;
document.getElementById(‘sg1’).style.display=‘none’;
document.getElementById(‘sg2’).style.display=‘none’;
}
function cancelEdit(){ clearForm(); }
function resetBtnState(){
editId=null;
const bs=document.getElementById(‘btnSave’);
bs.textContent=‘✅ บันทึกข้อมูล’; bs.className=‘btn btn-primary’;
document.getElementById(‘editInd’).classList.remove(‘show’);
document.getElementById(‘btnCancel’).style.display=‘none’;
}

// ── CAPACITY ────────────────────────────────────────────────────
let donutChart=null;
function updateCapacity(){
const used = DB.cold.filter(r=>r.status===‘ยังอยู่’).length;
const total = CAP;
const free = Math.max(0, total - used);
const pct = total>0 ? Math.round(used/total*100) : 0;

// sidebar
const sbFill=document.getElementById(‘sbCapFill’);
const fillColor = pct>=90?‘var(–red)’:pct>=70?‘var(–orange)’:‘var(–teal)’;
if(sbFill){ sbFill.style.width=Math.min(pct,100)+’%’; sbFill.style.background=fillColor; }
document.getElementById(‘sbCapUsed’).textContent=used+’ ใช้’;
document.getElementById(‘sbCapFree’).textContent=free+’ ว่าง’;
document.getElementById(‘sbCapTotal’).textContent=total+’ ทั้งหมด’;

// main widget
document.getElementById(‘capPct’).textContent=pct+’%’;
document.getElementById(‘capPct’).style.color=fillColor;
const pctUsed=total>0?(used/total*100):0;
const pctFree=total>0?(free/total*100):0;
document.getElementById(‘cBarUsed’).style.width=Math.min(pctUsed,100)+’%’;
document.getElementById(‘cBarFree’).style.width=Math.min(pctFree,100)+’%’;
document.getElementById(‘cNumUsed’).textContent=used;
document.getElementById(‘cNumFree’).textContent=free;

// alarm
const alarm=document.getElementById(‘capAlarm’);
if(pct>=90){ alarm.style.display=‘flex’; alarm.style.background=‘var(–red-bg)’; alarm.style.color=‘var(–red)’; alarm.style.borderLeft=‘3px solid var(–red)’; alarm.textContent=‘⚠️ เตือน! ห้องแช่ใกล้เต็มแล้ว (’+pct+’%)’; }
else if(pct>=70){ alarm.style.display=‘flex’; alarm.style.background=‘var(–orange-bg)’; alarm.style.color=‘var(–orange)’; alarm.style.borderLeft=‘3px solid var(–orange)’; alarm.textContent=‘⚡ แจ้งเตือน: ห้องแช่ใช้ไป ‘+pct+’%’; }
else { alarm.style.display=‘none’; }

// donut chart
const canvas=document.getElementById(‘capDonut’);
if(!canvas) return;
if(donutChart) donutChart.destroy();
donutChart = new Chart(canvas.getContext(‘2d’),{
type:‘doughnut’,
data:{ datasets:[{ data:[used,free,Math.max(0,0)],
backgroundColor:[fillColor,‘var(–green)’,‘transparent’],
borderWidth:0, hoverOffset:4 }] },
options:{ cutout:‘72%’, plugins:{legend:{display:false},tooltip:{enabled:false}}, animation:{animateRotate:true} }
});
}

// ── RENDER TABLES ────────────────────────────────────────────────
const fd = d => d?d.split(’-’).reverse().join(’/’):’’;
const B = (t,cls) => t?`<span class="badge ${cls}">${t}</span>`:’’;
const ageGroup = a => {
const n=parseInt(a)||0;
if(!a||a===’’) return ‘ไม่ทราบ’;
if(n<1) return ‘< 1 ปี’; if(n<=12) return ‘1-12 ปี’; if(n<=17) return ‘13-17 ปี’;
if(n<=35) return ‘18-35 ปี’; if(n<=60) return ‘36-60 ปี’; return ‘> 60 ปี’;
};

function renderTbl(type, q=’’){
q=(q||’’).toLowerCase();
let rows=DB[type].filter(r=>JSON.stringify(r).toLowerCase().includes(q));

// update hero stats
if(type===‘cold’){
document.getElementById(‘cold-active’).textContent=DB.cold.filter(r=>r.status===‘ยังอยู่’).length;
document.getElementById(‘cold-done’).textContent=DB.cold.filter(r=>r.status===‘รับศพแล้ว’).length;
}

const rc=document.getElementById(‘rc-’+{cold:‘cold’,evidence:‘ev’,autopsy:‘auto’,scene:‘sc’,infant:‘inf’,formalin:‘fml’}[type]);
if(rc) rc.textContent=rows.length+’ รายการ’;

let html=’<table><thead><tr>’;
let hdrs=[];
if(type===‘cold’) hdrs=[’#’,‘ชื่อ-นามสกุล’,‘เพศ’,‘อายุ’,‘สัญชาติ’,‘ตู้แช่’,‘วันเริ่มฝาก’,‘วันรับ’,‘วัน’,‘รวม(บ.)’,‘สถานะ’,‘จัดการ’];
else if(type===‘evidence’) hdrs=[’#’,‘รายละเอียด’,‘จำนวน’,‘แผนก’,‘วันรับ’,‘วันมอบ’,‘พงส.’,‘สภ.’,‘สถานะ’,‘จัดการ’];
else if(type===‘autopsy’) hdrs=[’#’,‘F-Number’,‘ชื่อ-นามสกุล’,‘เพศ’,‘อายุ’,‘สภ.’,‘ต้นทาง’,‘วันรับ’,‘วันผ่า’,‘แพทย์’,‘จัดการ’];
else if(type===‘scene’) hdrs=[’#’,‘วันที่’,‘เวลา’,‘ชื่อ-นามสกุล’,‘เพศ’,‘สภ.’,‘พงส.’,‘ผลดำเนินการ’,‘จัดการ’];
else if(type===‘infant’) hdrs=[’#’,‘ประเภท’,‘ชื่อ/ชนิด’,‘จำนวน’,‘วันฝาก’,‘แผนก’,‘ส่งฝัง’,‘จัดการ’];
else if(type===‘formalin’) hdrs=[’#’,‘วันที่’,‘ชื่อ-นามสกุล’,‘อายุ’,‘เพศ’,‘ค่าใช้จ่าย’,‘เจ้าหน้าที่’,‘ชำระ’,‘รับศพ’,‘จัดการ’];

hdrs.forEach(h=>html+=`<th>${h}</th>`);
html+=’</tr></thead><tbody>’;

if(!rows.length){
html+=`<tr><td colspan="${hdrs.length}" style="padding:40px;text-align:center;color:var(--text3)"><div style="font-size:2rem;margin-bottom:8px">📭</div>ยังไม่มีข้อมูล</td></tr>`;
} else {
rows.forEach((r,i)=>{
const alt=i%2?‘alt’:’’;
html+=`<tr class="${alt}">`;
html+=`<td class="td-num">${i+1}</td>`;
if(type===‘cold’){
const stCls=r.status===‘ยังอยู่’?‘bg-orange’:‘bg-green’;
html+=`<td class="left" style="font-weight:600">${r.name}</td><td>${r.gender||'-'}</td><td>${r.age||'-'}</td><td>${r.nation||'-'}</td> <td style="font-family:var(--font-mono)">${r.cabinet||'-'}</td><td>${fd(r.dateIn)}</td><td>${fd(r.dateOut)||'-'}</td> <td style="font-family:var(--font-mono)">${r.days||0}</td> <td style="font-weight:700;color:var(--green);font-family:var(--font-mono)">${r.cost?r.cost.toLocaleString('th-TH',{minimumFractionDigits:2}):'-'}</td> <td>${B(r.status,stCls)}</td>`;
} else if(type===‘evidence’){
const stCls=r.status===‘มอบแล้ว’?‘bg-green’:‘bg-yellow’;
html+=`<td class="left">${r.desc}</td><td>${r.qty||'-'}</td><td>${r.dept||'-'}</td> <td>${fd(r.dateIn)}</td><td>${fd(r.dateOut)||'-'}</td> <td class="left">${r.officer||'-'}</td><td>${r.station||'-'}</td><td>${B(r.status,stCls)}</td>`;
} else if(type===‘autopsy’){
html+=`<td style="font-family:var(--font-mono);color:var(--purple);font-weight:700">${r.fnum||'-'}</td> <td class="left" style="font-weight:600">${r.name}</td><td>${r.gender||'-'}</td><td>${r.age||'-'}</td> <td>${r.station||'-'}</td><td>${r.source||'-'}</td> <td>${fd(r.dateIn)}</td><td>${fd(r.dateAuto)||'-'}</td><td>${r.doctor||'-'}</td>`;
} else if(type===‘scene’){
const resCls=r.result===‘มอบคืนญาติ’?‘bg-green’:r.result===‘นำเข้าผ่าศพ’?‘bg-purple’:‘bg-gray’;
html+=`<td>${fd(r.date)}</td><td style="font-family:var(--font-mono)">${r.time||'-'}</td> <td class="left" style="font-weight:600">${r.name}</td><td>${r.gender||'-'}</td> <td>${r.station||'-'}</td><td>${r.officer||'-'}</td><td>${B(r.result,resCls)}</td>`;
} else if(type===‘infant’){
const sCls=r.buried?‘bg-green’:‘bg-orange’;
const label=r.subtype===‘ศพทารก’?r.name:r.orgType;
const qty=r.subtype===‘อวัยวะ’?r.qty:’-’;
html+=`<td>${B(r.subtype,r.subtype==='ศพทารก'?'bg-pink':'bg-teal')}</td> <td class="left" style="font-weight:600">${label||'-'}</td><td>${qty}</td> <td>${fd(r.dateIn)}</td><td>${r.dept||'-'}</td> <td>${B(r.buried?'ส่งแล้ว':'รอส่งฝัง',sCls)}</td>`;
} else if(type===‘formalin’){
const paidCls=r.paid?‘bg-green’:‘bg-red’;
const takenCls=r.taken?‘bg-green’:‘bg-orange’;
html+=`<td>${fd(r.date)}</td><td class="left" style="font-weight:600">${r.name}</td> <td>${r.age||'-'}</td><td>${r.gender||'-'}</td> <td style="font-weight:700;color:var(--yellow);font-family:var(--font-mono)">${r.cost?r.cost.toLocaleString('th-TH',{minimumFractionDigits:2}):'-'}</td> <td>${r.staff||'-'}</td> <td>${B(r.paid?'ชำระแล้ว':'ยังไม่ชำระ',paidCls)}</td> <td>${B(r.taken?'รับแล้ว':'รอรับ',takenCls)}</td>`;
}
html+=`<td> <button class="act-btn act-edit" onclick="editRec('${type}','${r.id}')">✏️</button> <button class="act-btn act-del" onclick="confirmDel('${type}','${r.id}')">🗑</button> </td></tr>`;
});
}
html+=’</tbody></table>’;
document.getElementById(‘tbl-’+type).innerHTML=html;
}

// ── EDIT ─────────────────────────────────────────────────────────
function sv(id,v){ const el=document.getElementById(id); if(el&&v!==undefined&&v!==null) el.value=v; }
function sc(id,v){ const el=document.getElementById(id); if(el) el.checked=!!v; }

function editRec(type,id){
const r=DB[type].find(x=>x.id===id); if(!r) return;
nav(‘entry’); setSection(type);
if(type===‘cold’){
sv(‘c_name’,r.name);sv(‘c_gender’,r.gender);sv(‘c_age’,r.age);sv(‘c_nation’,r.nation);
sv(‘c_cab’,r.cabinet);sv(‘c_din’,r.dateIn);sv(‘c_tin’,r.timeIn);sv(‘c_rate’,r.rate);
sv(‘c_dout’,r.dateOut);sv(‘c_note’,r.note); calcCold();
} else if(type===‘evidence’){
sv(‘e_desc’,r.desc);sv(‘e_qty’,r.qty);sv(‘e_dept’,r.dept);sv(‘e_din’,r.dateIn);
sv(‘e_recv’,r.receiver);sv(‘e_dout’,r.dateOut);sv(‘e_offi’,r.officer);
sv(‘e_ph’,r.phone);sv(‘e_stn’,r.station);sv(‘e_note’,r.note);
} else if(type===‘autopsy’){
sv(‘a_fn’,r.fnum);sv(‘a_name’,r.name);sv(‘a_gender’,r.gender);sv(‘a_age’,r.age);
sv(‘a_nat’,r.nation);sv(‘a_stn’,r.station);sv(‘a_src’,r.source);sv(‘a_hosp’,r.hospital);
sv(‘a_din’,r.dateIn);sv(‘a_daut’,r.dateAuto);sv(‘a_doc’,r.doctor);
sv(‘a_c1’,r.cause1);sv(‘a_c2’,r.cause2);sv(‘a_sp’,r.special);sv(‘a_note’,r.note);
} else if(type===‘scene’){
sv(‘s_dt’,r.date);sv(‘s_tm’,r.time);sv(‘s_name’,r.name);sv(‘s_gen’,r.gender);
sv(‘s_loc’,r.location);sv(‘s_stn’,r.station);sv(‘s_offi’,r.officer);
sv(‘s_ph’,r.phone);sv(‘s_stf’,r.staff);sv(‘s_doc’,r.doctor);
sv(‘s_res’,r.result);sv(‘s_cold’,r.cold);sv(‘s_retdt’,r.retdate);sv(‘s_note’,r.note);
sceneSubToggle();
} else if(type===‘infant’){
infantSubSwitch(r.subtype===‘ศพทารก’?‘infant’:‘organ’);
if(r.subtype===‘ศพทารก’){
sv(‘inf_name’,r.name);sv(‘inf_gen’,r.gender);sv(‘inf_wt’,r.weight);sv(‘inf_ga’,r.ga);
sv(‘inf_din’,r.dateIn);sv(‘inf_dept’,r.dept);sv(‘inf_mother’,r.mother);
sv(‘inf_bury’,r.buryDate);sc(‘inf_buried’,r.buried);sv(‘inf_note’,r.note);
} else {
sv(‘org_type’,r.orgType);sv(‘org_qty’,r.qty);sv(‘org_din’,r.dateIn);
sv(‘org_dept’,r.dept);sv(‘org_case’,r.caseName);sv(‘org_bury’,r.buryDate);
sc(‘org_buried’,r.buried);sv(‘org_note’,r.note);
}
} else if(type===‘formalin’){
sv(‘f_dt’,r.date);sv(‘f_name’,r.name);sv(‘f_age’,r.age);sv(‘f_gen’,r.gender);
sv(‘f_cost’,r.cost);sv(‘f_staff’,r.staff);sc(‘f_paid’,r.paid);sc(‘f_taken’,r.taken);
sv(‘f_retdt’,r.retdate);sv(‘f_note’,r.note); formalinRetToggle();
}
editId=id; curSec=type;
const bs=document.getElementById(‘btnSave’);
bs.textContent=‘💾 อัพเดทข้อมูล’; bs.className=‘btn’; bs.style.background=‘var(–purple)’; bs.style.color=‘white’;
const ei=document.getElementById(‘editInd’);
const seq=DB[type].findIndex(x=>x.id===id)+1;
ei.textContent=`✏️ กำลังแก้ไขรายการที่ ${seq}`;
ei.classList.add(‘show’);
document.getElementById(‘btnCancel’).style.display=‘flex’;
window.scrollTo(0,0);
}

// ── DELETE ───────────────────────────────────────────────────────
let pendingDel=null;
function confirmDel(type,id){
const r=DB[type].find(x=>x.id===id); if(!r) return;
const name=r.name||r.desc||r.orgType||r.fnum||‘รายการนี้’;
document.getElementById(‘mdl-msg’).textContent=`ต้องการลบ "${name}" ใช่หรือไม่? การลบไม่สามารถกู้คืนได้`;
pendingDel={type,id};
document.getElementById(‘mdl’).classList.add(‘show’);
document.getElementById(‘mdl-ok’).onclick=doDelete;
}
function doDelete(){
if(!pendingDel) return;
DB[pendingDel.type]=DB[pendingDel.type].filter(r=>r.id!==pendingDel.id);
saveDB(pendingDel.type); updateBadges(); updateCapacity(); renderTbl(pendingDel.type,’’);
closeMdl(); toast(‘🗑 ลบข้อมูลเรียบร้อย’,‘ok’);
}
function closeMdl(){ document.getElementById(‘mdl’).classList.remove(‘show’); pendingDel=null; }

// ── SUMMARY & CHARTS ─────────────────────────────────────────────
let chartInstances=[];
function destroyCharts(){ chartInstances.forEach(c=>c.destroy()); chartInstances=[]; }

function renderSummary(){
destroyCharts();
const mo=parseInt(document.getElementById(‘sm_mo’).value);
const yr=parseInt(document.getElementById(‘sm_yr’).value)-543;
function filt(type,dateField){
return DB[type].filter(r=>{
if(!r[dateField]) return false;
const d=new Date(r[dateField]);
return mo===0?d.getFullYear()===yr:(d.getFullYear()===yr&&d.getMonth()+1===mo);
});
}
const cold=filt(‘cold’,‘dateIn’), ev=filt(‘evidence’,‘dateIn’),
auto=filt(‘autopsy’,‘dateIn’), scene=filt(‘scene’,‘date’),
inf=filt(‘infant’,‘dateIn’), fml=filt(‘formalin’,‘date’);
const rev=cold.reduce((s,r)=>s+(r.cost||0),0);
const fmlRev=fml.reduce((s,r)=>s+(r.cost||0),0);

// Stat cards
const stats=[
{icon:‘🧊’,num:cold.length,lbl:‘ห้องศพ’,sub:cold.filter(r=>r.status===‘ยังอยู่’).length+’ ยังอยู่’,color:’–blue’},
{icon:‘🔍’,num:ev.length,lbl:‘วัตถุพยาน’,sub:ev.filter(r=>r.status===‘รอมอบ’).length+’ รอมอบ’,color:’–teal’},
{icon:‘🔬’,num:auto.length,lbl:‘ผ่าศพ’,sub:auto.filter(r=>r.source===‘เคสออกชันสูตรเอง’).length+’ เคสเอง’,color:’–purple’},
{icon:‘🚨’,num:scene.length,lbl:‘ชันสูตร’,sub:scene.filter(r=>r.result===‘นำเข้าผ่าศพ’).length+’ นำเข้า’,color:’–orange’},
{icon:‘🍼’,num:inf.length,lbl:‘ทารก/อวัยวะ’,sub:inf.filter(r=>r.buried).length+’ ส่งฝังแล้ว’,color:’–pink’},
{icon:‘💉’,num:fml.length,lbl:‘ฉีดฟอร์มาลีน’,sub:fml.filter(r=>r.paid).length+’ ชำระแล้ว’,color:’–yellow’},
{icon:‘💰’,num:rev.toLocaleString(‘th-TH’,{maximumFractionDigits:0}),lbl:‘รายได้ห้องศพ’,sub:‘บาท’,color:’–green’},
{icon:‘💊’,num:fmlRev.toLocaleString(‘th-TH’,{maximumFractionDigits:0}),lbl:‘รายได้ฟอร์มาลีน’,sub:‘บาท’,color:’–yellow’},
];
document.getElementById(‘sum-stats’).innerHTML=stats.map(s=>` <div class="stat-card" style="border-left:3px solid var(${s.color});color:var(${s.color})"> <div class="sc-icon">${s.icon}</div> <div class="sc-num">${s.num}</div> <div class="sc-lbl">${s.lbl}</div> <div class="sc-sub">${s.sub}</div> </div>`).join(’’);

// Charts
const CHART_OPT={
responsive:true, maintainAspectRatio:false,
plugins:{legend:{labels:{color:’#8B949E’,font:{family:‘Sarabun’,size:11}}}},
scales:{x:{ticks:{color:’#8B949E’},grid:{color:‘rgba(48,54,61,0.5)’}},
y:{ticks:{color:’#8B949E’},grid:{color:‘rgba(48,54,61,0.5)’},beginAtZero:true}}
};
const PIE_OPT={
responsive:true, maintainAspectRatio:false,
plugins:{legend:{position:‘right’,labels:{color:’#8B949E’,font:{family:‘Sarabun’,size:11},boxWidth:12}}}
};
const COLORS=[’#2F81F7’,’#2DD4BF’,’#A78BFA’,’#F0883E’,’#3FB950’,’#F778BA’,’#E3B341’,’#F85149’];

// All-type data for charts
const allWithDate = [
…DB.cold.map(r=>({…r,_type:‘cold’,_date:r.dateIn})),
…DB.autopsy.map(r=>({…r,_type:‘autopsy’,_date:r.dateIn})),
…DB.scene.map(r=>({…r,_type:‘scene’,_date:r.date})),
…DB.formalin.map(r=>({…r,_type:‘formalin’,_date:r.date})),
…DB.infant.map(r=>({…r,_type:‘infant’,_date:r.dateIn})),
];
const filteredAll = allWithDate.filter(r=>{
if(!r._date) return false;
const d=new Date(r._date);
return mo===0?d.getFullYear()===yr:(d.getFullYear()===yr&&d.getMonth()+1===mo);
});

// Gender pie chart
const genderData = {ชาย:0,หญิง:0,‘ไม่ทราบ’:0};
filteredAll.forEach(r=>{ const g=r.gender||‘ไม่ทราบ’; if(genderData[g]!==undefined) genderData[g]++; else genderData[‘ไม่ทราบ’]++; });

// Age group bar chart
const ageGroups={’< 1 ปี’:0,‘1-12 ปี’:0,‘13-17 ปี’:0,‘18-35 ปี’:0,‘36-60 ปี’:0,’> 60 ปี’:0,‘ไม่ทราบ’:0};
filteredAll.forEach(r=>{ const g=ageGroup(r.age); ageGroups[g]=(ageGroups[g]||0)+1; });

// Monthly bar chart (all services)
const monthNames=[‘ม.ค.’,‘ก.พ.’,‘มี.ค.’,‘เม.ย.’,‘พ.ค.’,‘มิ.ย.’,‘ก.ค.’,‘ส.ค.’,‘ก.ย.’,‘ต.ค.’,‘พ.ย.’,‘ธ.ค.’];
const moCold=monthNames.map((*,mi)=>DB.cold.filter(r=>{const d=new Date(r.dateIn);return d.getFullYear()===yr&&d.getMonth()===mi}).length);
const moAuto=monthNames.map((*,mi)=>DB.autopsy.filter(r=>{const d=new Date(r.dateIn);return d.getFullYear()===yr&&d.getMonth()===mi}).length);
const moScene=monthNames.map((*,mi)=>DB.scene.filter(r=>{const d=new Date(r.date);return d.getFullYear()===yr&&d.getMonth()===mi}).length);
const moFml=monthNames.map((*,mi)=>DB.formalin.filter(r=>{const d=new Date(r.date);return d.getFullYear()===yr&&d.getMonth()===mi}).length);

// Station distribution
const stationMap={};
[…auto,…scene].forEach(r=>{ if(r.station) stationMap[r.station]=(stationMap[r.station]||0)+1; });
const stationKeys=Object.keys(stationMap).sort((a,b)=>stationMap[b]-stationMap[a]).slice(0,8);

// Revenue monthly
const moRev=monthNames.map((*,mi)=>DB.cold.filter(r=>{const d=new Date(r.dateIn);return d.getFullYear()===yr&&d.getMonth()===mi}).reduce((s,r)=>s+(r.cost||0),0));
const moFmlRev=monthNames.map((*,mi)=>DB.formalin.filter(r=>{const d=new Date(r.date);return d.getFullYear()===yr&&d.getMonth()===mi}).reduce((s,r)=>s+(r.cost||0),0));

// Render chart containers
document.getElementById(‘sum-charts-top’).innerHTML=` <div class="chart-card"> <div class="chart-title">📊 จำนวนเคสรายเดือน</div> <div class="chart-wrap"><canvas id="ch-monthly"></canvas></div> </div> <div class="chart-card"> <div class="chart-title">⚤ สัดส่วนตามเพศ (รวมทุกงาน)</div> <div class="chart-wrap"><canvas id="ch-gender"></canvas></div> </div>`;
document.getElementById(‘sum-charts-mid’).innerHTML=` <div class="chart-card"> <div class="chart-title">👤 การกระจายตามช่วงอายุ</div> <div class="chart-wrap"><canvas id="ch-age"></canvas></div> </div> <div class="chart-card"> <div class="chart-title">🏢 เคสแยกตาม สภ.</div> <div class="chart-wrap"><canvas id="ch-station"></canvas></div> </div> <div class="chart-card"> <div class="chart-title">💰 รายได้รายเดือน (บาท)</div> <div class="chart-wrap"><canvas id="ch-revenue"></canvas></div> </div>`;

// Monthly bar
chartInstances.push(new Chart(document.getElementById(‘ch-monthly’).getContext(‘2d’),{
type:‘bar’,
data:{labels:monthNames, datasets:[
{label:‘ห้องศพ’,data:moCold,backgroundColor:‘rgba(47,129,247,0.7)’,borderRadius:4},
{label:‘ผ่าศพ’,data:moAuto,backgroundColor:‘rgba(167,139,250,0.7)’,borderRadius:4},
{label:‘ชันสูตร’,data:moScene,backgroundColor:‘rgba(240,136,62,0.7)’,borderRadius:4},
{label:‘ฟอร์มาลีน’,data:moFml,backgroundColor:‘rgba(227,179,65,0.7)’,borderRadius:4},
]},
options:{…CHART_OPT,plugins:{…CHART_OPT.plugins,legend:{…CHART_OPT.plugins.legend}}}
}));

// Gender pie
chartInstances.push(new Chart(document.getElementById(‘ch-gender’).getContext(‘2d’),{
type:‘doughnut’,
data:{labels:Object.keys(genderData),datasets:[{
data:Object.values(genderData),
backgroundColor:[‘rgba(47,129,247,0.85)’,‘rgba(247,120,186,0.85)’,‘rgba(110,118,129,0.85)’],
borderWidth:2, borderColor:[’#2F81F7’,’#F778BA’,’#6E7681’]
}]},
options:{…PIE_OPT}
}));

// Age bar
chartInstances.push(new Chart(document.getElementById(‘ch-age’).getContext(‘2d’),{
type:‘bar’,
data:{labels:Object.keys(ageGroups),datasets:[{
label:‘จำนวน’,data:Object.values(ageGroups),
backgroundColor:COLORS.map(c=>c+‘CC’), borderRadius:5, borderWidth:0
}]},
options:{…CHART_OPT,plugins:{…CHART_OPT.plugins,legend:{display:false}},indexAxis:‘y’}
}));

// Station bar
chartInstances.push(new Chart(document.getElementById(‘ch-station’).getContext(‘2d’),{
type:‘bar’,
data:{labels:stationKeys,datasets:[{
label:‘เคส’,data:stationKeys.map(k=>stationMap[k]),
backgroundColor:‘rgba(45,212,191,0.7)’, borderRadius:5
}]},
options:{…CHART_OPT,plugins:{…CHART_OPT.plugins,legend:{display:false}}}
}));

// Revenue
chartInstances.push(new Chart(document.getElementById(‘ch-revenue’).getContext(‘2d’),{
type:‘line’,
data:{labels:monthNames,datasets:[
{label:‘ห้องศพ’,data:moRev,borderColor:’#2F81F7’,backgroundColor:‘rgba(47,129,247,0.1)’,tension:.4,fill:true,pointRadius:4},
{label:‘ฟอร์มาลีน’,data:moFmlRev,borderColor:’#E3B341’,backgroundColor:‘rgba(227,179,65,0.1)’,tension:.4,fill:true,pointRadius:4},
]},
options:{…CHART_OPT}
}));

// Monthly table
const totals=[0,0,0,0,0,0];
let tblHtml=`<thead><tr>
<th>เดือน</th><th>🧊 ห้องศพ</th><th>🔍 วัตถุพยาน</th><th>🔬 ผ่าศพ</th>
<th>🚨 ชันสูตร</th><th>🍼 ทารก/อวัยวะ</th><th>💉 ฟอร์มาลีน</th><th>💰 รายได้ (บ.)</th>

  </tr></thead><tbody>`;
  monthNames.forEach((mn,mi)=>{
    const m=mi+1;
    const cf=DB.cold.filter(r=>{const d=new Date(r.dateIn);return d.getFullYear()===yr&&d.getMonth()+1===m}).length;
    const ef=DB.evidence.filter(r=>{const d=new Date(r.dateIn);return d.getFullYear()===yr&&d.getMonth()+1===m}).length;
    const af=DB.autopsy.filter(r=>{const d=new Date(r.dateIn);return d.getFullYear()===yr&&d.getMonth()+1===m}).length;
    const sf=DB.scene.filter(r=>{const d=new Date(r.date);return d.getFullYear()===yr&&d.getMonth()+1===m}).length;
    const inf2=DB.infant.filter(r=>{const d=new Date(r.dateIn);return d.getFullYear()===yr&&d.getMonth()+1===m}).length;
    const ff=DB.formalin.filter(r=>{const d=new Date(r.date);return d.getFullYear()===yr&&d.getMonth()+1===m}).length;
    const rev2=DB.cold.filter(r=>{const d=new Date(r.dateIn);return d.getFullYear()===yr&&d.getMonth()+1===m}).reduce((s,r)=>s+(r.cost||0),0)
             +DB.formalin.filter(r=>{const d=new Date(r.date);return d.getFullYear()===yr&&d.getMonth()+1===m}).reduce((s,r)=>s+(r.cost||0),0);
    totals[0]+=cf;totals[1]+=ef;totals[2]+=af;totals[3]+=sf;totals[4]+=inf2;totals[5]+=ff;
    tblHtml+=`<tr><td><b>${mn}</b></td><td>${cf||'-'}</td><td>${ef||'-'}</td><td>${af||'-'}</td>
      <td>${sf||'-'}</td><td>${inf2||'-'}</td><td>${ff||'-'}</td>
      <td>${rev2>0?rev2.toLocaleString('th-TH',{minimumFractionDigits:2}):'-'}</td></tr>`;
  });
  const totalRev=DB.cold.filter(r=>new Date(r.dateIn).getFullYear()===yr).reduce((s,r)=>s+(r.cost||0),0)
               +DB.formalin.filter(r=>new Date(r.date).getFullYear()===yr).reduce((s,r)=>s+(r.cost||0),0);
  tblHtml+=`<tr><td>รวมทั้งปี</td><td>${totals[0]}</td><td>${totals[1]}</td><td>${totals[2]}</td>
    <td>${totals[3]}</td><td>${totals[4]}</td><td>${totals[5]}</td>
    <td>${totalRev.toLocaleString('th-TH',{minimumFractionDigits:2})}</td></tr></tbody>`;
  document.getElementById('sum-month-tbl').innerHTML=tblHtml;
}

// ── PDF / PRINT ──────────────────────────────────────────────────
function printReport(){
const mo=parseInt(document.getElementById(‘sm_mo’).value);
const yr=document.getElementById(‘sm_yr’).value;
const moName=[’’,‘มกราคม’,‘กุมภาพันธ์’,‘มีนาคม’,‘เมษายน’,‘พฤษภาคม’,‘มิถุนายน’,‘กรกฎาคม’,‘สิงหาคม’,‘กันยายน’,‘ตุลาคม’,‘พฤศจิกายน’,‘ธันวาคม’];
const title=`รายงานสรุปนิติเวช ${mo>0?moName[mo]+' ':''}ปี พ.ศ. ${yr}`;
const style=` <style> @import url('https://fonts.googleapis.com/css2?family=Sarabun:wght@400;600;700&display=swap'); *{font-family:'Sarabun',sans-serif;box-sizing:border-box} body{background:#fff;color:#111;padding:32px;font-size:13px} h1{font-size:18px;margin-bottom:4px;color:#1B3A6B} .sub{color:#666;font-size:12px;margin-bottom:24px} table{width:100%;border-collapse:collapse;margin-bottom:20px} th{background:#1B3A6B;color:white;padding:8px 10px;text-align:center;font-size:11px} td{padding:7px 10px;border-bottom:1px solid #E5E7EB;text-align:center} tr:last-child td{font-weight:700;background:#F3F4F6} .stats{display:flex;flex-wrap:wrap;gap:12px;margin-bottom:24px} .stat{background:#F3F4F6;border-radius:8px;padding:12px 16px;flex:1;min-width:120px} .stat .n{font-size:24px;font-weight:700;color:#1B3A6B} .stat .l{font-size:11px;color:#666} @media print{body{padding:16px}} </style>`;
const tblEl=document.getElementById(‘sum-month-tbl’);
const w=window.open(’’,’_blank’);
w.document.write(`<!DOCTYPE html><html><head><meta charset="UTF-8"><title>${title}</title>${style}</head><body>
<h1>📊 ${title}</h1>
<div class="sub">แผนกนิติเวช โรงพยาบาลกระบี่ · จัดทำเมื่อ ${new Date().toLocaleDateString(‘th-TH’)}</div>
<div id="sum-stats-print"></div>
<table>${tblEl.innerHTML}</table>
<script>window.print();window.close();</script>

  </body></html>`);
  w.document.close();
}

// ── EXPORT CSV ───────────────────────────────────────────────────
function exportAll(){
const secs=[
{key:‘cold’,name:‘ห้องศพ’,fields:[‘name’,‘gender’,‘age’,‘nation’,‘cabinet’,‘dateIn’,‘timeIn’,‘rate’,‘dateOut’,‘days’,‘cost’,‘status’,‘note’]},
{key:‘evidence’,name:‘วัตถุพยาน’,fields:[‘desc’,‘qty’,‘dept’,‘dateIn’,‘receiver’,‘dateOut’,‘officer’,‘phone’,‘station’,‘status’,‘note’]},
{key:‘autopsy’,name:‘ผ่าศพ’,fields:[‘fnum’,‘name’,‘gender’,‘age’,‘nation’,‘station’,‘source’,‘hospital’,‘dateIn’,‘dateAuto’,‘doctor’,‘cause1’,‘cause2’,‘special’,‘note’]},
{key:‘scene’,name:‘ชันสูตร’,fields:[‘date’,‘time’,‘name’,‘gender’,‘location’,‘station’,‘officer’,‘phone’,‘staff’,‘doctor’,‘result’,‘cold’,‘retdate’,‘note’]},
{key:‘infant’,name:‘ทารก-อวัยวะ’,fields:[‘subtype’,‘name’,‘orgType’,‘qty’,‘gender’,‘weight’,‘ga’,‘dateIn’,‘dept’,‘mother’,‘caseName’,‘buried’,‘buryDate’,‘note’]},
{key:‘formalin’,name:‘ฟอร์มาลีน’,fields:[‘date’,‘name’,‘age’,‘gender’,‘cost’,‘staff’,‘paid’,‘taken’,‘retdate’,‘note’]},
];
secs.forEach(s=>{
if(!DB[s.key].length) return;
let csv=’\uFEFF’+s.fields.join(’,’)+’\n’;
DB[s.key].forEach(r=>{ csv+=s.fields.map(f=>’”’+String(r[f]||’’).replace(/”/g,’””’)+’”’).join(’,’)+’\n’; });
const a=document.createElement(‘a’);
a.href=URL.createObjectURL(new Blob([csv],{type:‘text/csv;charset=utf-8’}));
a.download=`forensic_${s.key}_${new Date().toISOString().slice(0,10)}.csv`;
a.click();
});
toast(‘⬇️ Export เรียบร้อยแล้ว’,‘ok’);
}

// ── HOSXP ────────────────────────────────────────────────────────
let hosxpConnected=false;
function toggleHosXP(){
const p=document.getElementById(‘hosxpPanel’);
p.classList.toggle(‘show’);
}
function fetchHN(){
const hn=document.getElementById(‘hn-input’).value.trim();
if(!hn){toast(‘กรุณาใส่ HN’,‘err’);return;}
document.getElementById(‘hn-status’).textContent=‘กำลังค้นหา…’;
// Demo: simulate HosXP API call
// ในการใช้งานจริง เปลี่ยน URL เป็น http://localhost:PORT/api/patient?hn=xxx
// หรือ http://HOSXP_SERVER/hosxp_api/patient.php?hn=xxx
if(!hosxpConnected){
document.getElementById(‘hn-name’).value=‘ตัวอย่าง: สมชาย ใจดี (ต้องเชื่อมต่อ HosXP)’;
document.getElementById(‘hn-age’).value=‘45 ปี’;
document.getElementById(‘hn-status’).textContent=‘⚠️ Demo Mode — เชื่อมต่อ HosXP จริงผ่าน API endpoint’;
toast(‘Demo Mode: กำหนดค่า HosXP API ใน config ก่อน’,‘err’);
}
}
function fillFromHN(){
const name=document.getElementById(‘hn-name’).value;
const age=document.getElementById(‘hn-age’).value.replace(/[^0-9]/g,’’);
if(name && curSec){
const fields={cold:‘c_name’,evidence:’’,autopsy:‘a_name’,scene:‘s_name’,formalin:‘f_name’};
const ageFields={cold:‘c_age’,autopsy:‘a_age’,scene:’’,formalin:‘f_age’};
if(fields[curSec]) sv(fields[curSec],name);
if(ageFields[curSec]) sv(ageFields[curSec],age);
toast(‘นำข้อมูล HosXP ใส่ฟอร์มแล้ว’,‘ok’);
}
}

// ── AUTOCOMPLETE ─────────────────────────────────────────────────
function updateAutocomplete(){
const names=[…new Set(DB.cold.map(r=>r.name).filter(Boolean))];
const cabs=[…new Set(DB.cold.map(r=>r.cabinet).filter(Boolean))];
const staff=[…new Set([…DB.evidence.map(r=>r.receiver),…DB.scene.map(r=>r.staff)].filter(Boolean))];
const offi=[…new Set([…DB.evidence.map(r=>r.officer),…DB.scene.map(r=>r.officer)].filter(Boolean))];
const docs=[…new Set([…DB.autopsy.map(r=>r.doctor),…DB.scene.map(r=>r.doctor)].filter(Boolean))];
const fnums=[…new Set(DB.autopsy.map(r=>r.fnum).filter(Boolean))];
const stf=[…new Set(DB.scene.map(r=>r.staff).filter(Boolean))];
const f2=[…new Set(DB.formalin.map(r=>r.staff).filter(Boolean))];
const fill=(id,arr)=>{const el=document.getElementById(id);if(el)el.innerHTML=arr.map(v=>`<option value="${v}">`).join(’’)};
fill(‘dl-names’,names);fill(‘dl-cab’,cabs);fill(‘dl-staff’,staff);fill(‘dl-staff2’,f2);
fill(‘dl-offi’,offi);fill(‘dl-offi2’,offi);fill(‘dl-doc’,docs);fill(‘dl-doc2’,docs);
fill(‘dl-stf’,stf);fill(‘dl-fnum’,fnums);
}

// ── BADGES ───────────────────────────────────────────────────────
function updateBadges(){
document.getElementById(‘b-cold’).textContent=DB.cold.length;
document.getElementById(‘b-ev’).textContent=DB.evidence.length;
document.getElementById(‘b-auto’).textContent=DB.autopsy.length;
document.getElementById(‘b-scene’).textContent=DB.scene.length;
document.getElementById(‘b-infant’).textContent=DB.infant.length;
document.getElementById(‘b-formalin’).textContent=DB.formalin.length;
}

// ── TODAY COUNT ──────────────────────────────────────────────────
function updateTodayCount(){
const today=new Date().toISOString().slice(0,10);
let n=0;
for(let k in DB) if(Array.isArray(DB[k])) n+=DB[k].filter(r=>r.createdAt&&r.createdAt.slice(0,10)===today).length;
document.getElementById(‘today-count’).textContent=n;
let total=0; for(let k in DB) if(Array.isArray(DB[k])) total+=DB[k].length;
document.getElementById(‘total-count’).textContent=total;
}

// ── TOAST ─────────────────────────────────────────────────────────
function toast(msg,type=‘ok’){
const t=document.getElementById(‘toast’);
t.textContent=msg; t.className=‘toast ‘+type+’ show’;
setTimeout(()=>t.classList.remove(‘show’),3000);
}

// ── UTILS ─────────────────────────────────────────────────────────
const uid=()=>Date.now()+’_’+Math.random().toString(36).slice(2,6);
const now=()=>new Date().toISOString();

// ── CLOCK ─────────────────────────────────────────────────────────
function tick(){
const d=new Date();
document.getElementById(‘topClock’).textContent=
d.toLocaleTimeString(‘th-TH’,{hour:‘2-digit’,minute:‘2-digit’,second:‘2-digit’,timeZone:‘Asia/Bangkok’});
}

// ── INIT ──────────────────────────────────────────────────────────
document.addEventListener(‘DOMContentLoaded’,()=>{
loadDB(); updateBadges(); updateAutocomplete(); updateTodayCount();
tick(); setInterval(tick,1000);
updateCapacity();
// Set today as default date
const today=new Date().toISOString().slice(0,10);
[‘c_din’,‘e_din’,‘a_din’,‘s_dt’,‘inf_din’,‘org_din’,‘f_dt’].forEach(id=>{
const el=document.getElementById(id); if(el&&!el.value) el.value=today;
});
document.getElementById(‘sm_yr’).value=(new Date().getFullYear()+543);
// Keyboard shortcut: Ctrl+S = save
document.addEventListener(‘keydown’,e=>{
if(e.ctrlKey&&e.key===‘s’){e.preventDefault();saveRec();}
if(e.key===‘Escape’) closeMdl();
});
});

</script>
</body>
</html>
