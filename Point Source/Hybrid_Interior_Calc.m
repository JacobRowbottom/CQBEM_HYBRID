%% Calculates Interior solution via CQBEM using the Boundary solution previously calculated via the Hybrid method.
parfor ll =1:N 
    tn = (ll-1)*dt;
    for ipx=1:NP
         for ipy=1:NP  
             utildeInter(ipx,ipy,ll) = CQBEM_Inter_Point(k(ll),utildeB(:,ll),Ftilde_BC(:,ll),M,IPx(ipx),IPy(ipy),NVert,nEdge,cEdge,a,b,xv,yv,CosEdgeAngle,SinEdgeAngle,CL,nx,ny);
             Greenfun(ipx,ipy,ll) = GreenFunction_PS(IPx(ipx),IPy(ipy),PSx,PSy,c,tn,alpha,t0); %Incident solution
         end
    end
end

% INVERSE FFT FOR INTERIOR SOLUTION
InputInt=zeros(NP,NP,N);
uInter=zeros(NP,NP,N);
for ipx=1:NP
    for ipy=1:NP
        InputInt(ipx,ipy,:) = (ifft(utildeInter(ipx,ipy,:))); 
    end
end
for n=1:N
    uInter(:,:,n)=((lambda)^(1-n))*InputInt(:,:,n); % uInter = Interior solution in time domain at each interior point
end

Phi = uInter + Greenfun; % POINT SOURCE CALC (Phi = U + V)

 for tt=1:N
     uInterior(tt) = real(uInter(1,1,tt));
     GFInterior(tt) = real(Greenfun(1,1,tt));
     PhiInterior(tt) = real(Phi(1,1,tt));
 end
 
 figure
 plot(t,uInterior)
 hold on
 plot(t,GFInterior)
 plot(t,PhiInterior)