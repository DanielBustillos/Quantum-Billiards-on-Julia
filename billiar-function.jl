function billarobsblue(x0,y0,vx,vy,prim, it)
 err=0.02                      # definimos el error como !!!poner en latex !!!!
 posBarrx=5                    # Se define la posición de las barreras laterales
 t=linspace(0,100,10000);      # Se define lista de 10000 "tiempos"
    
for j in 1:it 
       posx = zeros(10000);     # Se define una lista de 1000 entradas para guardar la posicion en x & y.
       posy = zeros(10000);
    choquex = zeros(it);     # Lista para guardar donde choca en x & y
    choquey = zeros(it);

    for i in 1:10000    # Primero guardemos la trayectoria de las particula en las siguientes listas:    
        posx[i] = x0+vx*t[i]
        posy[i] = y0+vy*t[i]
    end
                                 # Se revisa la posición de choque como sigue:
            for i in 1:10000     # Se hacen correr todos los puntos (x,y) de la trayectoria y se observa cuando 
                                 # cumplen la ecuación de la circunferencia " y = sqrt(1-x^2) "
            
      # Una vez guardado los datos, se definen una serie de ifs que revisan cuando la posición de la partícula
            # cumple con las ecuaciones del circulo x^2+y^2=r^2. Se hacer 4 ifs para los dos medios circulos
                # y dos más para las barreras laterales.
            

                    # medio circulo superior derecha
                    if abs(posy[i]-5-sqrt.(25.01-(posx[i])*(posx[i])))<err  && 0<posx[i]<5.1                      
                          x0 = posx[i]; # guardamos la posicion del choque en la posicion donde se cunple el if
                          y0 = posy[i];
                           m = x0/sqrt(abs(25.1-x0^2)); # encontramos la pendiente del plano tangente definido 
                                                          # por su derivada
                            if x0 > 0                     # definimos esta if para que no haya problemas
                                m=-abs(m);
                                end 
                        phi = atand(m);                   # El ángulo del plano con la horizontaL
                         cx = cosd(phi);                  # Se calculan la componentes de la normal
                         cy = sind(phi);                  # cy es la normal en x y cy la normal en y
                          n = SVector(abs(cy), abs(cx));  # definimos la normal con lso vectores normales
                          V = SVector(vx, vy);            # Se define el vector director con las vel. iniciales
                         k2 = dot(2V,n)                   # a continuación se encuentra el vector resultante
                         k3 = k2*n;                       # esto pudo haber sido una sola linea pero
                          r = V-k3;                       # había problemas y por eso no salía
                         vx = r[1];                       # Se renombran "vx" y "vy" como la primera                 
                         vy = r[2];                       # y segunda entrada del vector resultante
                         x0 = posx[i-1];                  # por ultimo, guardamos un paso antes para 
                         y0 = posy[i-1];                  # que no haya problemas en la siguiente iteración.
                              break
                
              #medio circulo superior de la izquierda!!!    
                elseif abs(posy[i]-5-sqrt.(25.01-(posx[i])*(posx[i])))<err  && 0>posx[i]>-5.1                    
                         x0 = posx[i];
                          y0 = posy[i];
                         m = x0/sqrt(abs(25.1-x0^2));
                            if x0 > 0
                                m=-abs(m);
                                end 
                        phi = atand(m); 
                         cx = cosd(phi);  
                         cy = sind(phi);9
                          n = SVector(abs(cy), -abs(cx));
                          V = SVector(vx, vy);
                         k2 = dot(2V,n)
                         k3 = k2*n;
                          r = V-k3;
                         vx = r[1];
                         vy = r[2];
                         x0 = posx[i-1];
                         y0 = posy[i-1];
                              break
                
                        #medio círculo inferior de la izquierda
                        elseif abs(posy[i]+5+sqrt.(25.01-(posx[i])*(posx[i])))<err  &&   0>posx[i]>-5.1                 
                          x0 = posx[i];
                          y0 = posy[i];
                         m = x0/sqrt(abs(25.1-x0^2));
                            if x0 > 0
                                m=abs(m);
                                end 
                        phi = atand(m);
                         cx = cosd(phi);
                         cy = sind(phi);
                          n = SVector(-abs(cy), -abs(cx));
                          V = SVector(vx, vy);
                         k2 = dot(2V,n);
                         k3 = k2*n;
                          r = V-k3;
                         vx = r[1];
                         vy = r[2];
                         x0 = posx[i-1];
                         y0 = posy[i-1];
                              break
                
                  #medio círculo inferior de la derecha:
                        elseif abs(posy[i]+5+sqrt.(25.01-(posx[i])*(posx[i])))<err  && 0<posx[i]<5.1              
                        x0 = posx[i];
                          y0 = posy[i];
                         m = x0/sqrt(abs(25.1-x0^2));
                            if x0 > 0
                                m=abs(m);
                                end 
                        phi = atand(m); 
                         cx = cosd(phi);
                         cy = sind(phi);
                          n = SVector(-abs(cy), abs(cx));
                          V = SVector(vx, vy); 
                         k2 = dot(2V,n);
                         k3 = k2*n;
                          r = V-k3;
                         vx = r[1];
                         vy = r[2];
                         x0 = posx[i-1];
                         y0 = posy[i-1];
                              break
                
                

                 # por ultimo la condicion del OBSTACULO interior
                
                 # interior superior derecha
                elseif abs(posy[i]-sqrt.(abs.(1-(posx[i])*(posx[i]))))<err   && -0.1<posx[i]<1.2
                          x0 = posx[i]; # guardamos la posicion del choque en la posicion donde se cunple el if
                          y0 = posy[i];
                           m = x0/sqrt(abs(1.1-x0^2));  
                                                          # por su derivada
                            if x0 > 0                     # definimos esta if para que no haya problemas
                                m=-abs(m);
                                end 
                    
                        phi = atand(m);         # El ángulo del plano con la horizontaL
                         cx = cosd(phi);        # Se calculan la componentes de la normal
                         cy = sind(phi);        # cy es la normal en x y cy la normal en y
                          n = SVector(abs(cy), abs(cx));   # definimos la normal con lso vectores normales
                          V = SVector(vx, vy);  # Se define el vector director con las velocidades iniciales
                         k2 = dot(2V,n)         # a continuación se encuentra el vector resultante
                         k3 = k2*n;             # esto pudo haber sido una sola linea pero
                          r = V-k3;                     #había problemas y por eso no salía
                         vx = r[1];             # Se renombran "vx" y "vy" como la primera y segunda entrada del                   
                         vy = r[2];             # vector resultante
                         x0 = posx[i-1];        # por ultimo, guardamos un paso antes para que no haya problemas
                         y0 = posy[i-1];        # en la siguiente iteración.
                              break
                
                  # interior superior izq
                elseif abs(posy[i]-sqrt.(abs.(1-(posx[i])*(posx[i]))))<err  &&  -0.1>posx[i]>-1.1  
                          x0 = posx[i];
                          y0 = posy[i];
                           m = x0/sqrt(abs(1.1-x0^2));
                
                            if x0 > 0
                             m=-abs(m);
                                end 
                    
                        phi = atand(m); 
                         cx = cosd(phi);  
                         cy = sind(phi);
                          n = SVector(abs(cy), -abs(cx));
                          V = SVector(vx, vy);
                         k2 = dot(2V,n)
                         k3 = k2*n;
                          r = V-k3;
                         vx = r[1];
                         vy = r[2];
                         x0 = posx[i-1];
                         y0 = posy[i-1];
                              break
            
                        # interior inferior izq
                        elseif abs(posy[i]+sqrt.(abs.(1-(posx[i])*(posx[i]))))<err  &&   0>posx[i]>-1.1  
                          x0 = posx[i];
                          y0 = posy[i];
                         m = x0/sqrt(abs(1.1-x0^2));
                
                            if x0 > 0
                                m=abs(m);
                                end 
                
                        phi = atand(m);
                         cx = cosd(phi);
                         cy = sind(phi);
                          n = SVector(-abs(cy), -abs(cx));
                          V = SVector(vx, vy);
                         k2 = dot(2V,n);
                         k3 = k2*n;
                          r = V-k3;
                         vx = r[1];
                         vy = r[2];
                         x0 = posx[i-1];
                         y0 = posy[i-1];
                              break
                
                  # interior inferior derecha
                        elseif abs(posy[i]+sqrt.(abs.(1-(posx[i])*(posx[i]))))<err  && 0 < posx[i] < 1.1 
                        x0 = posx[i];
                          y0 = posy[i];
                         m = x0/sqrt(abs(1.1-x0^2));
                
                            if x0 > 0
                                m=abs(m);
                                end 
                
                        phi = atand(m); 
                         cx = cosd(phi);
                         cy = sind(phi);
                          n = SVector(-abs(cy), abs(cx));
                          V = SVector(vx, vy); 
                         k2 = dot(2V,n);
                         k3 = k2*n;
                          r = V-k3;
                         vx = r[1];
                         vy = r[2];
                         x0 = posx[i-1];
                         y0 = posy[i-1];
                              break
                
                       #Ahora para las paredes verticales:
                          #pared izquierda
                            elseif abs(posx[i]+posBarrx)<err  && posx[i]<0 &&abs(posy[i])<6
                
                                    x0 = posx[i-1]     #para no tener problemas en la siguiente iteración
                                    y0 = posy[i];
                                    vx = -vx;          #Ya que es lo única componente que cambia 
                                     break
                         
                            #pared derecha
                            elseif abs(posx[i]-posBarrx)<err && posx[i]>0 && abs(posy[i])<6
                
                                    x0 = posx[i-1];
                                    y0 = posy[i];
                                    vx = -vx;
                                     break    
                    
            end
       
              if j>prim
             push!(choquex,posx[i]) # Para cada "i" guardamos "posx[i]" y "posy[i]" en las listas
             push!(choquey,posy[i]) # "choquex" y "choquey"
            end
             end
 
   x1 = linspace(-5.0, 5, 100)           # Se define un linspace para poder graficar los medios círculos
  yar = 5+sqrt.(abs.(25-x1.*x1))         # Se definen las ecuaciones de los medios circulos para poder graficar
  yab = -5-sqrt.(abs.(25-x1.*x1))
  x12 = linspace(-1, 1, 100)             # Se define un linspace para poder graficar el círculo central en un futuro
 yar2 = sqrt.(abs.(1-x12.*x12))          # Se definen las ecuaciones del círculo central para graficar 
 yab2 = -sqrt.(abs.(1-x12.*x12))     
        
 plot(x1, yab,color="black")             #estas son las graficas de los circulos
 plot(x1, yar,color="black")
 plot(x12, yab2,color="orange")
 plot(x12, yar2,color="orange")
           
 plot([-5,-5],[-5,5],linestyle="-",linewidth=1.5,color="black")         # aquí graficamos las lineas horizontales
 plot([5,5],[-5,5],linestyle="-",linewidth=1.5,color="black")
              
 xlim(-11, 11)
 ylim(-10.5, 10.5)

plot(choquex,choquey, ".",alpha=1, linewidth=0.002, color="blue", markersize=1,antialiased=true)    # esta es la grafica de las trayectorias
                                                                      #(lo que no sale bien)
    end
end


function billarobsgreen(x0,y0,vx,vy,prim,it)
 err=0.02                      # definimos el error como !!!poner en latex !!!!
 posBarrx=5                    # Se define la posición de las barreras laterales
 t=linspace(0,100,10000);      # Se define lista de 10000 "tiempos"
    
for j in 1:it 
       posx = zeros(10000);     # Se define una lista de 1000 entradas para guardar la posicion en x & y.
       posy = zeros(10000);
    choquex = zeros(it);     # Lista para guardar donde choca en x & y
    choquey = zeros(it);

    for i in 1:10000    # Primero guardemos la trayectoria de las particula en las siguientes listas:    
        posx[i] = x0+vx*t[i]
        posy[i] = y0+vy*t[i]
    end
                                 # Se revisa la posición de choque como sigue:
            for i in 1:10000     # Se hacen correr todos los puntos (x,y) de la trayectoria y se observa cuando 
                                 # cumplen la ecuación de la circunferencia " y = sqrt(1-x^2) "
            
      # Una vez guardado los datos, se definen una serie de ifs que revisan cuando la posición de la partícula
            # cumple con las ecuaciones del circulo x^2+y^2=r^2. Se hacer 4 ifs para los dos medios circulos
                # y dos más para las barreras laterales.
            

                    # medio circulo superior derecha
                    if abs(posy[i]-5-sqrt.(25.01-(posx[i])*(posx[i])))<err  && 0<posx[i]<5.1                      
                          x0 = posx[i]; # guardamos la posicion del choque en la posicion donde se cunple el if
                          y0 = posy[i];
                           m = x0/sqrt(abs(25.1-x0^2)); # encontramos la pendiente del plano tangente definido 
                                                          # por su derivada
                            if x0 > 0                     # definimos esta if para que no haya problemas
                                m=-abs(m);
                                end 
                        phi = atand(m);                   # El ángulo del plano con la horizontaL
                         cx = cosd(phi);                  # Se calculan la componentes de la normal
                         cy = sind(phi);                  # cy es la normal en x y cy la normal en y
                          n = SVector(abs(cy), abs(cx));  # definimos la normal con lso vectores normales
                          V = SVector(vx, vy);            # Se define el vector director con las vel. iniciales
                         k2 = dot(2V,n)                   # a continuación se encuentra el vector resultante
                         k3 = k2*n;                       # esto pudo haber sido una sola linea pero
                          r = V-k3;                       # había problemas y por eso no salía
                         vx = r[1];                       # Se renombran "vx" y "vy" como la primera                 
                         vy = r[2];                       # y segunda entrada del vector resultante
                         x0 = posx[i-1];                  # por ultimo, guardamos un paso antes para 
                         y0 = posy[i-1];                  # que no haya problemas en la siguiente iteración.
                              break
                
              #medio circulo superior de la izquierda!!!    
                elseif abs(posy[i]-5-sqrt.(25.01-(posx[i])*(posx[i])))<err  && 0>posx[i]>-5.1                    
                         x0 = posx[i];
                          y0 = posy[i];
                         m = x0/sqrt(abs(25.1-x0^2));
                            if x0 > 0
                                m=-abs(m);
                                end 
                        phi = atand(m); 
                         cx = cosd(phi);  
                         cy = sind(phi);9
                          n = SVector(abs(cy), -abs(cx));
                          V = SVector(vx, vy);
                         k2 = dot(2V,n)
                         k3 = k2*n;
                          r = V-k3;
                         vx = r[1];
                         vy = r[2];
                         x0 = posx[i-1];
                         y0 = posy[i-1];
                              break
                
                        #medio círculo inferior de la izquierda
                        elseif abs(posy[i]+5+sqrt.(25.01-(posx[i])*(posx[i])))<err  &&   0>posx[i]>-5.1                 
                          x0 = posx[i];
                          y0 = posy[i];
                         m = x0/sqrt(abs(25.1-x0^2));
                            if x0 > 0
                                m=abs(m);
                                end 
                        phi = atand(m);
                         cx = cosd(phi);
                         cy = sind(phi);
                          n = SVector(-abs(cy), -abs(cx));
                          V = SVector(vx, vy);
                         k2 = dot(2V,n);
                         k3 = k2*n;
                          r = V-k3;
                         vx = r[1];
                         vy = r[2];
                         x0 = posx[i-1];
                         y0 = posy[i-1];
                              break
                
                  #medio círculo inferior de la derecha:
                        elseif abs(posy[i]+5+sqrt.(25.01-(posx[i])*(posx[i])))<err  && 0<posx[i]<5.1              
                        x0 = posx[i];
                          y0 = posy[i];
                         m = x0/sqrt(abs(25.1-x0^2));
                            if x0 > 0
                                m=abs(m);
                                end 
                        phi = atand(m); 
                         cx = cosd(phi);
                         cy = sind(phi);
                          n = SVector(-abs(cy), abs(cx));
                          V = SVector(vx, vy); 
                         k2 = dot(2V,n);
                         k3 = k2*n;
                          r = V-k3;
                         vx = r[1];
                         vy = r[2];
                         x0 = posx[i-1];
                         y0 = posy[i-1];
                              break
                
                

                 # por ultimo la condicion del OBSTACULO interior
                
                 # interior superior derecha
                elseif abs(posy[i]-sqrt.(abs.(1-(posx[i])*(posx[i]))))<err   && -0.1<posx[i]<1.2
                          x0 = posx[i]; # guardamos la posicion del choque en la posicion donde se cunple el if
                          y0 = posy[i];
                           m = x0/sqrt(abs(1.1-x0^2));  
                                                          # por su derivada
                            if x0 > 0                     # definimos esta if para que no haya problemas
                                m=-abs(m);
                                end 
                    
                        phi = atand(m);         # El ángulo del plano con la horizontaL
                         cx = cosd(phi);        # Se calculan la componentes de la normal
                         cy = sind(phi);        # cy es la normal en x y cy la normal en y
                          n = SVector(abs(cy), abs(cx));   # definimos la normal con lso vectores normales
                          V = SVector(vx, vy);  # Se define el vector director con las velocidades iniciales
                         k2 = dot(2V,n)         # a continuación se encuentra el vector resultante
                         k3 = k2*n;             # esto pudo haber sido una sola linea pero
                          r = V-k3;                     #había problemas y por eso no salía
                         vx = r[1];             # Se renombran "vx" y "vy" como la primera y segunda entrada del                   
                         vy = r[2];             # vector resultante
                         x0 = posx[i-1];        # por ultimo, guardamos un paso antes para que no haya problemas
                         y0 = posy[i-1];        # en la siguiente iteración.
                              break
                
                  # interior superior izq
                elseif abs(posy[i]-sqrt.(abs.(1-(posx[i])*(posx[i]))))<err  &&  -0.1>posx[i]>-1.1  
                          x0 = posx[i];
                          y0 = posy[i];
                           m = x0/sqrt(abs(1.1-x0^2));
                
                            if x0 > 0
                             m=-abs(m);
                                end 
                    
                        phi = atand(m); 
                         cx = cosd(phi);  
                         cy = sind(phi);
                          n = SVector(abs(cy), -abs(cx));
                          V = SVector(vx, vy);
                         k2 = dot(2V,n)
                         k3 = k2*n;
                          r = V-k3;
                         vx = r[1];
                         vy = r[2];
                         x0 = posx[i-1];
                         y0 = posy[i-1];
                              break
            
                        # interior inferior izq
                        elseif abs(posy[i]+sqrt.(abs.(1-(posx[i])*(posx[i]))))<err  &&   0>posx[i]>-1.1  
                          x0 = posx[i];
                          y0 = posy[i];
                         m = x0/sqrt(abs(1.1-x0^2));
                
                            if x0 > 0
                                m=abs(m);
                                end 
                
                        phi = atand(m);
                         cx = cosd(phi);
                         cy = sind(phi);
                          n = SVector(-abs(cy), -abs(cx));
                          V = SVector(vx, vy);
                         k2 = dot(2V,n);
                         k3 = k2*n;
                          r = V-k3;
                         vx = r[1];
                         vy = r[2];
                         x0 = posx[i-1];
                         y0 = posy[i-1];
                              break
                
                  # interior inferior derecha
                        elseif abs(posy[i]+sqrt.(abs.(1-(posx[i])*(posx[i]))))<err  && 0 < posx[i] < 1.1 
                        x0 = posx[i];
                          y0 = posy[i];
                         m = x0/sqrt(abs(1.1-x0^2));
                
                            if x0 > 0
                                m=abs(m);
                                end 
                
                        phi = atand(m); 
                         cx = cosd(phi);
                         cy = sind(phi);
                          n = SVector(-abs(cy), abs(cx));
                          V = SVector(vx, vy); 
                         k2 = dot(2V,n);
                         k3 = k2*n;
                          r = V-k3;
                         vx = r[1];
                         vy = r[2];
                         x0 = posx[i-1];
                         y0 = posy[i-1];
                              break
                
                       #Ahora para las paredes verticales:
                          #pared izquierda
                            elseif abs(posx[i]+posBarrx)<err  && posx[i]<0 &&abs(posy[i])<6
                
                                    x0 = posx[i-1]     #para no tener problemas en la siguiente iteración
                                    y0 = posy[i];
                                    vx = -vx;          #Ya que es lo única componente que cambia 
                                     break
                         
                            #pared derecha
                            elseif abs(posx[i]-posBarrx)<err && posx[i]>0 && abs(posy[i])<6
                
                                    x0 = posx[i-1];
                                    y0 = posy[i];
                                    vx = -vx;
                                     break    
                    
            end
        if j>prim
             push!(choquex,posx[i]) # Para cada "i" guardamos "posx[i]" y "posy[i]" en las listas
             push!(choquey,posy[i]) # "choquex" y "choquey"
            end
             end
 
   x1 = linspace(-5.0, 5, 100)           # Se define un linspace para poder graficar los medios círculos
  yar = 5+sqrt.(abs.(25-x1.*x1))         # Se definen las ecuaciones de los medios circulos para poder graficar
  yab = -5-sqrt.(abs.(25-x1.*x1))
  x12 = linspace(-1, 1, 100)             # Se define un linspace para poder graficar el círculo central en un futuro
 yar2 = sqrt.(abs.(1-x12.*x12))          # Se definen las ecuaciones del círculo central para graficar 
 yab2 = -sqrt.(abs.(1-x12.*x12))     
        
 plot(x1, yab,color="black")             #estas son las graficas de los circulos
 plot(x1, yar,color="black")
 plot(x12, yab2,color="orange")
 plot(x12, yar2,color="orange")
           
 plot([-5,-5],[-5,5],linestyle="-",linewidth=1.5,color="black")         # aquí graficamos las lineas horizontales
 plot([5,5],[-5,5],linestyle="-",linewidth=1.5,color="black")
              
 xlim(-11, 11)
 ylim(-10.5, 10.5)
     
plot(choquex,choquey, ".",alpha=1, linewidth=0.002, color="green", markersize=1,antialiased=true)   # esta es la grafica de las trayectorias
    end
end
