Fs= 44100;
dur= 2; 
f = 523;

selec_harmo_a = 8;
wavetype = 1;
a = selector(selec_harmo_a,wavetype);

%rg_harmo_a = 21;
rg_res_lev = 1;
rg_center = 1;
rg_band_width = 1;
kyoushin= rg(selec_harmo_a, rg_res_lev, rg_center, rg_band_width);
a = a.*kyoushin;

lfo_depth = 0;
lfo_freq = 3;
%finst= lfo(dur,f,lfo_depth,lfo_freq,Fs);

f_at = 0.5;
f_dt = 0.2;
f_sl = 0.5;
f_rt = 0.4;
%oto= vco2(finst,a,dur,f_at,f_dt,f_sl,f_rt,Fs);

a_at = 0.5;
a_dt = 0.2;
a_sl = 0.5;
a_rt = 0.4;
%env= adsr(dur,a_at,a_dt,a_sl,a_rt,Fs);
%kekka= oto.*env;

hf = figure('units','pixel','position',[400 150 1000 800], 'color',[.2 .2 .2]);
haxes = axes('position',[0.65 0.7 0.3 0.25]); % 描画領域を作りハンドルを取得

%スライダーの横の文字
%text(10,10,'string', 'color',[0 1 0]);

%%ドレミを鳴らすボタンを作成
r2 = 2^(1/12);
f = 110*r2.^(3:12+12+12+3);

black = [f(2) f(4) f(7) f(9) f(11) ,...
         f(2+12) f(4+12) f(7+12) f(9+12) f(11+12) ,...
         f(2+24) f(4+24) f(7+24) f(9+24) f(11+24)];

white = [f(1) f(3) f(5) f(6) f(8) f(10) f(12) ,...
         f(1+12) f(3+12) f(5+12) f(6+12) f(8+12) f(10+12) f(12+12) ,...
         f(1+24) f(3+24) f(5+24) f(6+24) f(8+24) f(10+24) f(12+24)];

PitchClass = {'C','C#','D','D#','E','F','F#','G','G#','A','A#','B','C'};

%{
for i=1:13
    uicontrol( ...
        'style','pushbutton','units','normalized',...
        'position',[0.25*i/6 0.1 0.03 0.1],'string',PitchClass(i),...
        'BackgroundColor',[1 1 1],...
        'callback',...
        ['finst= lfo(dur,f(' num2str(i) '),lfo_depth,lfo_freq,Fs);' ,...
        'oto= vco2(finst,a,dur,f_at,f_dt,f_sl,f_rt,Fs);',...
        'env= adsr(dur,a_at,a_dt,a_sl,a_rt,Fs);' ,...
        'kekka= oto.*env; sound(kekka,Fs);' ,...
        'fftdata= disp_spec(kekka,512,256,Fs);' ]);
end
%}

%鍵盤を作る
for i=1:21
    uicontrol( ...
        'style','pushbutton','units','pixel',...
        'position',[30*i 95 30 110],...
        'BackgroundColor',[1 1 1],...
        'callback',...
        ['finst= lfo(dur,white(' num2str(i) '),lfo_depth,lfo_freq,Fs);' ,...
        'oto= vco2(finst,a,dur,f_at,f_dt,f_sl,f_rt,Fs);',...
        'env= adsr(dur,a_at,a_dt,a_sl,a_rt,Fs);' ,...
        'kekka= oto.*env; sound(kekka,Fs);' ,...
        'fftdata= disp_spec(kekka,512,256,Fs);' ]);
end

keyposi = [45 78 135 168 201 ,...
           45+210 78+210 135+210 168+210 201+210 ,...
           45+420 78+420 135+420 168+420 201+420];

for i=1:15
    uicontrol( ...
        'style','pushbutton','units','pixel',...
        'position',[keyposi(i) 150 25 55],...
        'BackgroundColor',[0 0 0],...
        'callback',...
        ['finst= lfo(dur,black(' num2str(i) '),lfo_depth,lfo_freq,Fs);' ,...
        'oto= vco2(finst,a,dur,f_at,f_dt,f_sl,f_rt,Fs);',...
        'env= adsr(dur,a_at,a_dt,a_sl,a_rt,Fs);' ,...
        'kekka= oto.*env; sound(kekka,Fs);' ,...
        'fftdata= disp_spec(kekka,512,256,Fs);' ]);
end


% 音全体の長さを調整した時のコールバックコマンド
cmddur = ['dur=get(hsdur,''value''); env=adsr(dur,a_at,a_dt,a_sl,a_rt,Fs); plot(haxes,env);'];
% 音全体の長さを調整するスライダー
hsdur = uicontrol('style','slider','units','normalized',...
    'position',[0.1 0.87 0.4 0.03],'max',3,'min',0,...
    'value',dur,'callback',cmddur, 'Backgroundcolor',[.7 .7 .7  ]);
%上の文字
uicontrol('style','text','units','normalized','position',[0.25 0.91 0.12 0.03],'string','duration', 'Backgroundcolor',[.4 .9 .4],'FontSize',18);



%音色を選ぶポップアップ
cmd1 = ['val = get(sound_chenge,''value'');' 'wavetype = val;' 'a = selector(selec_harmo_a,wavetype);',...
    'kyoushin= rg(selec_harmo_a, rg_res_lev, rg_center, rg_band_width);' 'a = a.*kyoushin;'];
sound_chenge = uicontrol('style','popupmenu','units','normalized',...
     'String', 'sin|saw|squere','position',[0.1 0.73 0.1 0.05],...
     'callback',cmd1, 'Backgroundcolor',[.7 .7 .7  ]);
%上の文字
uicontrol('style','text','units','normalized','position',[0.1 0.785 0.11 0.03],'string','wavetype', 'Backgroundcolor',[.4 .9 .4],'FontSize',18);



%倍音の数を決めるテキストボックス
cmd2 = ['s=get(hed,''string'');' 'selec_harmo_a=str2num(s);' 'a = selector(selec_harmo_a,wavetype);',...
    'kyoushin= rg(selec_harmo_a, rg_res_lev, rg_center, rg_band_width);' 'a = a.*kyoushin;'];
hed = uicontrol('style','edit' ,'units','normalized', 'position',[0.26 0.756 0.1 0.028], ...
    'string',num2str(selec_harmo_a), 'callback',cmd2, 'Backgroundcolor',[.7 .7 .7  ]);
%上の文字
uicontrol('style','text','units','normalized','position',[0.26 0.785 0.08 0.03],'string','amount', 'Backgroundcolor',[.4 .9 .4],'FontSize',18);



%RGの振幅倍率を決めるテキストボックス
rg_cmd1 = ['r1 = get(rg_1,''string'');' 'rg_res_lev = str2num(r1);'...
           'a = selector(selec_harmo_a,wavetype);',...
           'kyoushin= rg(selec_harmo_a, rg_res_lev, rg_center, rg_band_width);' 'a = a.*kyoushin;'];
rg_1 = uicontrol('style','edit' ,'units','normalized', 'position',[0.1 0.6 0.1 0.028], ...
    'string',num2str(rg_res_lev), 'callback',rg_cmd1, 'Backgroundcolor',[.7 .7 .7  ]);
%上の文字
uicontrol('style','text','units','normalized','position',[0.1 0.63 0.11 0.03],'string','resonance', 'Backgroundcolor',[.4 .9 .4],'FontSize',18);

%RGの中心倍音を決めるテキストボックス
rg_cmd2 = ['r2 = get(rg_2,''string'');' 'rg_center = str2num(r2);'...
           'a = selector(selec_harmo_a,wavetype);',...
           'kyoushin= rg(selec_harmo_a, rg_res_lev, rg_center, rg_band_width);' 'a = a.*kyoushin;'];
rg_2 = uicontrol('style','edit' ,'units','normalized', 'position',[0.26 0.6 0.1 0.028], ...
    'string',num2str(rg_center), 'callback',rg_cmd2, 'Backgroundcolor',[.7 .7 .7  ]);
%上の文字
uicontrol('style','text','units','normalized','position',[0.26 0.63 0.11 0.03],'string','res center', 'Backgroundcolor',[.4 .9 .4],'FontSize',18);

%RGのバンド幅を決めるテキストボックス
rg_cmd3 = ['r3 = get(rg_3,''string'');' 'rg_band_width = str2num(r3);'...
           'a = selector(selec_harmo_a,wavetype);',...
           'kyoushin= rg(selec_harmo_a, rg_res_lev, rg_center, rg_band_width);' 'a = a.*kyoushin;'];
rg_3 = uicontrol('style','edit' ,'units','normalized', 'position',[0.43 0.6 0.1 0.028], ...
    'string',num2str(rg_band_width), 'callback',rg_cmd3, 'Backgroundcolor',[.7 .7 .7  ]);
%上の文字
uicontrol('style','text','units','normalized','position',[0.43 0.63 0.11 0.03],'string','band width', 'Backgroundcolor',[.4 .9 .4],'FontSize',18);



% lfoの深さを調整した時のコールバックコマンド
lfocmd1 = ['lfo1=get(lfo_d,''value''); lfo_depth = lfo1;'];
% LFOの深さを調整するスライダー
lfo_d = uicontrol('style','slider','units','normalized',...
    'position',[0.1 0.45 0.2 0.025],'max',10,'min',0,...
    'value',lfo_depth,'callback',lfocmd1, 'Backgroundcolor',[.7 .7 .7  ]);
%上の文字
uicontrol('style','text','units','normalized','position',[0.12 0.48 0.17 0.03],'string','LFO depth', 'Backgroundcolor',[.4 .9 .4],'FontSize',18);

% lfoの周波数を調整した時のコールバックコマンド
lfocmd2 = ['lfo2=get(lfo_f,''value''); lfo_freq = lfo2;'];
% LFOの周波数を調整するスライダー
lfo_f = uicontrol('style','slider','units','normalized',...
    'position',[0.35 0.45 0.2 0.025],'max',100,'min',0,...
    'value',lfo_freq,'callback',lfocmd2, 'Backgroundcolor',[.7 .7 .7  ]);
%上の文字
uicontrol('style','text','units','normalized','position',[0.36 0.48 0.17 0.03],'string','LFO freq', 'Backgroundcolor',[.4 .9 .4],'FontSize',18);



% アンプのADSRをいじった時のコールバックコマンド
cmda = ['a_at = get(hsa,''value''); env=adsr(dur,a_at,a_dt,a_sl,a_rt,Fs); plot(haxes,env);'];
cmdd = ['a_dt = get(hsd,''value''); env=adsr(dur,a_at,a_dt,a_sl,a_rt,Fs); plot(haxes,env);'];
cmds = ['a_sl = get(hss,''value''); env=adsr(dur,a_at,a_dt,a_sl,a_rt,Fs); plot(haxes,env);'];
cmdr = ['a_rt = get(hsr,''value''); env=adsr(dur,a_at,a_dt,a_sl,a_rt,Fs); plot(haxes,env);'];

% アンプのADSRの長さを調整するスライダー
hsa = uicontrol('style','slider','units','normalized','position',[0.8 0.1 0.025 0.2],'value',a_at,'callback',cmda, 'Backgroundcolor',[.7 .7 .7  ]);
hsd = uicontrol('style','slider','units','normalized','position',[0.84 0.1 0.025 0.2],'value',a_dt,'callback',cmdd, 'Backgroundcolor',[.7 .7 .7  ]);
hss = uicontrol('style','slider','units','normalized','position',[0.88 0.1 0.025 0.2],'value',a_sl,'callback',cmds, 'Backgroundcolor',[.7 .7 .7  ]);
hsr = uicontrol('style','slider','units','normalized','position',[0.92 0.1 0.025 0.2],'value',a_rt,'callback',cmdr, 'Backgroundcolor',[.7 .7 .7  ]);
%上の文字
uicontrol('style','text','units','normalized','position',[0.7 0.15 0.07 0.06],'string','AMP ADSR', 'Backgroundcolor',[.4 .9 .4],'FontSize',18);



% フィルターのADSRをいじった時のコールバックコマンド
fcmda = ['f_at = get(fia,''value''); '];
fcmdd = ['f_dt = get(fid,''value''); '];
fcmds = ['f_sl = get(fis,''value''); '];
fcmdr = ['f_rt = get(fir,''value''); '];

% フィルターのADSRの長さを調整するスライダー
fia = uicontrol('style','slider','units','normalized','position',[0.8 0.4 0.025 0.2],'value',a_at,'callback',fcmda, 'Backgroundcolor',[.7 .7 .7  ]);
fid = uicontrol('style','slider','units','normalized','position',[0.84 0.4 0.025 0.2],'value',a_dt,'callback',fcmdd, 'Backgroundcolor',[.7 .7 .7  ]);
fis = uicontrol('style','slider','units','normalized','position',[0.88 0.4 0.025 0.2],'value',a_sl,'callback',fcmds, 'Backgroundcolor',[.7 .7 .7  ]);
fir = uicontrol('style','slider','units','normalized','position',[0.92 0.4 0.025 0.2],'value',a_rt,'callback',fcmdr, 'Backgroundcolor',[.7 .7 .7  ]);
%上の文字
uicontrol('style','text','units','normalized','position',[0.7 0.45 0.07 0.06],'string','Filter ADSR', 'Backgroundcolor',[.4 .9 .4],'FontSize',18);
