clc

egmdatnum = importdata('EGM2008PolandHeightAnomaly.gdf',' ',35);
egmdat = egmdatnum.textdata;
egmnum = egmdatnum.data;
la=egmnum(:,1);
fi=egmnum(:,2);
dat1=egmnum(:,4);
lamin=min(la);
lamax=max(la);
fimin=min(fi);
fimax=max(fi);

##plot(la,fi,dat1,'Color',[.4 .4 .4],'LineWidth',1);
##hold on

la1=la(1);la2=la(2);
  i=0;
  while la1==la2 
    i=i+1; 
    la2=la(2+i);
  end 
  fi1=fi(1);fi2=fi(2);
  j=0;
  while fi1==fi2
    j=j+1;
    fi2=fi(2+j);
  end
  dla=abs(la1-la2);
  dfi=abs(fi1-fi2);
  frows=abs(floor((fimax-fimin)/dfi+1.5));
  lcols=abs(floor((lamax-lamin)/dla+1.5));
  n=1;
  for i=frows:-1:1
    for j=1:lcols
      if n <= length(la) 
        if la(n) < 180
         X(i,j)=la(n);
        else
          X(i,j)=la(n)-360;
        end
      Y(i,j)=fi(n);
      Z(i,j) = dat1(n);
      n=n+1;
      end
    end    
  end
  
[c,h]=contourf(X,Y,Z,2.3475113E+01:1.2130566:4.7736245E+01);
clabel(c,h);
hold on

colorbar

ylabel('latitude')
xlabel('longitude')

bfid = fopen('polandn.bln');

while feof(bfid)==0;
    
    n = fscanf(bfid,'%i,%i',2);
    if isempty(n)==1;
        break
    end
    fila = fscanf(bfid,'%g,%g',[2 n(1)]);
    if n(1)~=length(fila(1,:));
        fila = fscanf(bfid,'%g %g',[2 n(1)]);
    end
    la=fila(1,:);
    fi=fila(2,:);
    plot(la,fi,'Color',[.17 .17 .17],'LineWidth',1);
    hold on

end