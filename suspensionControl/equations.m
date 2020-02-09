function [dx,oth] = equations(t,x)
% Global variables
global mus g kt ms bs ks ka T ma ba U X_i slope_i Rw bc flag
% Unpack variables
qt=x(1);
pus=x(2);
qs=x(3);
ps=x(4);
qa=x(5);
pa=x(6);

X=U*t;
slope=interp1(X_i,slope_i,X);
% slope=0;
vi = U*slope;
vs = ps/ms;

if flag ==1
    Fa=0;
    Sf=0;
    P=0;
else
    % Controller on
    Fa = bc*vs;
    Sf = bc*vs/T;
    P = Sf^2 *Rw;
end

dqt = vi - pus/mus;
dpus = qt*kt - mus*g-((pus/mus - ps/ms)*bs+qs*ks);
dqs = pus/mus - ps/ms;
dps = (pus/mus - ps/ms)*bs + (qs*ks) - (ms*g) - ((ps/ms - pa/ma)*ba+qa*ka)-Fa;
dqa = ps/ms - pa/ma;
dpa = (ps/ms - pa/ma)*ba +  qa*ka - ma*g +Fa;


dx =[dqt;dpus;dqs;dps;dqa;dpa];
oth = [vi;P;Fa]; % pressure and volume
end
