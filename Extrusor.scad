//
//--- Variables de Configuracion ---
//

//Filamento
diametroFilamento = 1.75;
ptfe = "si";

//Hotend
diametroHotend = 16;
endiduraHotend = 12;
longitudPreEndiduraHotend = 5.25;
longitudEndiduraHotend = 4.5;

//Soporte
altoSoporte = 68;
anchoSoporte = 55;

//Motor
largoMotor = 42.2;
profundoMotor = 40;
largoTornillo = 20;
separacionTornillos = 31;
diametroTaladroMotor = 3;

//Drive Gear
diametroDriveGear = 8;
diametroOrificioDG = 5;
altoDriveGear = 13.2;

//Rodamiento
//diametroRodamiento = 9;    ejeRodamiento = 3;  grosorRodamiento = 3;   //603
diametroRodamiento = 10;    ejeRodamiento = 3;  grosorRodamiento = 4;   //623
//diametroRodamiento = 13;    ejeRodamiento = 4;  grosorRodamiento = 5;   //624
//diametroRodamiento = 16;    ejeRodamiento = 5;  grosorRodamiento = 5;   //625

//Muelle Tensor
largoMaxMuelle = 16.5;
largoMinMuelle = 8.5;
idMuelle = 4.7;
odMuelle = 6.7;


//General
definicion = 100;
redondeo = 3;
margen = 2;
grosor=diametroHotend+6;


// ---

//posicionRodamiento=[(diametroDriveGear/2)+(diametroRodamiento/2)+(diametroFilamento/2), 0,0];
//posicionEjeTensor=[separacionTornillos/2,separacionTornillos/2, 0];

// ---

*taladros_motor();
filamento();

translate([0,0,(altoDriveGear/2)-1.7]) {
    rotate([0,180,0]) {
        drive_gear();
    }
}

*translate([0,0,-(profundoMotor/2)-(grosor/2)]) {
    rotate([0,90,0]) {
        nema_17();
    }
}

cuerpo_extrusor();

sujecion_hotend();


translate([(diametroDriveGear/2)+(diametroRodamiento/2)+(diametroFilamento/2),0,0]) {
    rodamiento();
}

brazo_tensor();

translate([(separacionTornillos/2)+(diametroTaladroMotor)+(largoMaxMuelle/2), 0, 0]) {
    muelle_tensor();
}

//--- Modulos ---


//
//Tensor Muelle
module tensor_muelle() {
    
    *cube([[0,0,0]], center =true);


    
    union() {
        union() {
            hull() {
                translate([(separacionTornillos/2)+(diametroTaladroMotor*2)+(largoMaxMuelle),0,0]) {
                    cylinder(d=diametroTaladroMotor*2, h=grosor, center=true);
                }
                translate([(separacionTornillos/2)+(diametroTaladroMotor*2)+(largoMaxMuelle),-(separacionTornillos/2),0]) {
                    cylinder(d=diametroTaladroMotor*3, h=grosor, center=true);
                }
            }
            
            translate([(separacionTornillos/2)+(diametroTaladroMotor)+(largoMaxMuelle) , 0, 0]) {
                rotate([0,90,0]) {
                    cylinder(d=idMuelle-0.5, h=(largoMinMuelle/3)*2, center=true, $fn=definicion);
                }
            }
        }
        
        difference() {
        
            hull() {
                translate([(separacionTornillos/2)+(diametroTaladroMotor*2)+(largoMaxMuelle),-(separacionTornillos/2),0]) {
                    cylinder(d=diametroTaladroMotor*3, h=grosor, center=true);
                }
                
                
                translate([(separacionTornillos/2),-(separacionTornillos/2),0]) {
                    cylinder(d=diametroTaladroMotor*3, h=grosor, center=true);
                }
            }

            translate([separacionTornillos/2,-separacionTornillos/2,0]) {
                cylinder(d=diametroTaladrosMotor, h=grosor+2, center=true, $fn=definicion);
            }
        
        }
        
    }
    
}

//


//
//Brazo Tensor

module brazo_tensor() {
    
    // v0.2 --->
    

    
    difference() {
        
            
        difference() {
        
            union() {
            
                difference() {
                    difference() {
                        union() {
                            hull() {
                                translate([separacionTornillos/2, separacionTornillos/2, 0]) {
                                    cylinder(d=diametroTaladroMotor*3, h=grosor, center=true, $fn=definicion);
                                }
                                translate([separacionTornillos/2, 0, 1]) {
                                    cylinder(d=diametroTaladroMotor*2, h=grosor-2, center=true, $fn=definicion);
                                }
                            }
                            
                            hull() {
                                translate([separacionTornillos/2, 0, 1]) {
                                    cylinder(d=diametroTaladroMotor*2, h=grosor-2, center=true, $fn=definicion);
                                }
                                translate([(diametroDriveGear/2)+(diametroRodamiento/2)+(diametroFilamento/2),0,1]) {
                                    cylinder(d=diametroRodamiento-1, h=grosor-2, center=true, $fn=definicion);
                                }
                            }
                        }
                        translate([(diametroDriveGear/2)+(diametroRodamiento/2)+(diametroFilamento/2),0,0]) {
                            cylinder(d=ejeRodamiento, h=grosor+2, center=true, $fn=definicion);
                        }
                    }
                
                    translate([separacionTornillos/2, separacionTornillos/2, 0]) {
                        cylinder(d=diametroTaladroMotor, h=grosor+2, center=true, $fn=definicion);
                    }
                }
                
                translate([(separacionTornillos/2)+(diametroTaladroMotor), 0, 0]) {
                    rotate([0,90,0]) {
                        cylinder(d=idMuelle-0.5, h=(largoMinMuelle/3)*2, center=true, $fn=definicion);
                    }
                }
            
            }
            
            translate([(diametroDriveGear/2)+(diametroRodamiento/2)+(diametroFilamento/2),0,-grosor/2]) {
                tuerca_sujecion(eje=3);
            }
        
        }

        translate([(diametroDriveGear/2)+(diametroRodamiento/2)+(diametroFilamento/2)/2,0,0]) {
            cylinder(d=diametroRodamiento+2, h=grosorRodamiento+2 , center = true, $fn=definicion);
        }
    
    }
    
    
    // <--- v0.2
    
    
    /* v0.1 --->
    
    difference() {
        difference() {
            difference() {
                difference() {
                    union() {
                        hull() {
                            translate([(diametroDriveGear/2)+(diametroRodamiento/2)+(diametroFilamento/2),0,0]) {
                                cylinder(d=diametroRodamiento-2, h=grosor,center=true, $fn=definicion);
                            }
                            translate([separacionTornillos/2,separacionTornillos/2,0]) {
                                cylinder(d=diametroTaladroMotor*3, h=grosor, center=true, $fn=definicion);
                            }
                        }
                    
                        hull() {
                        
                            translate([separacionTornillos/2,separacionTornillos/2,0]) {
                                cylinder(d=diametroTaladroMotor*3, h=grosor, center=true, $fn=definicion);
                            }
                            
                            translate([separacionTornillos/1.5,separacionTornillos/1.5,0]) {
                                cylinder(d=diametroTaladroMotor*3, h=grosor, center=true, $fn=definicion);
                            }
                        }
                    }
                    
                    translate([(diametroDriveGear/2)+(diametroRodamiento/2)+(diametroFilamento/2),0,0]) {
                        cylinder(d=diametroRodamiento+margen, h=grosorRodamiento+1, center = true, $fn=definicion);
                    }
                }
                translate([(diametroDriveGear/2)+(diametroRodamiento/2)+(diametroFilamento/2),0,0]) {
                    cylinder(d=ejeRodamiento, h=grosor+2, center=true, $fn=definicion);
                }
            }
            translate([(diametroDriveGear/2)+(diametroRodamiento/2)+(diametroFilamento/2),0,-grosor/2]) {
                tuerca_idler();
            }
        }
        translate([separacionTornillos/2,separacionTornillos/2,0]) {
            cylinder(d=diametroTaladroMotor, h=grosor+2, center=true, $fn=definicion);
        }
    }
    */// <--- v0.1
}

//Brazo Tensor
//

//----------------------------------------------------

//
//Hueco Brazo Tensor

module hueco_brazo_tensor() {
    
    
    // V0.2 --->
    union() {
        translate([(largoMotor/2)+1, (largoMotor/4)+1, 0]) {
            translate([-((largoMotor/2)-((diametroDriveGear/2)+(diametroRodamiento/2)+(diametroFilamento/2)/2))/2, -(diametroRodamiento+margen)/4,0]) {
                cube([(largoMotor/2)-((diametroDriveGear/2)+(diametroRodamiento/2)+(diametroFilamento/2)/2)+2,(largoMotor/2)+((diametroRodamiento+margen)/2)+2, grosor+2], center=true);
            }
        }
        translate([(diametroDriveGear/2)+(diametroRodamiento/2)+(diametroFilamento/2)/2,0,0]) {
            cylinder(d=diametroRodamiento+margen, h=grosor+2 , center = true, $fn=definicion);
        }
    }
    // <--- V0.2
    
    
    /*
    // V0.1 --->

    hull() {

        hull() {
        
            translate([(diametroDriveGear/2)+(diametroRodamiento/2)+(diametroFilamento/2),0,0]) {
                union() {
                    cylinder(d=diametroRodamiento+margen, h=grosor+4 , center = true, $fn=definicion);
                    translate([(diametroRodamiento+(2*diametroTaladroMotor)),0,0]) {
                        cube([2*(diametroRodamiento+(2*diametroTaladroMotor)),diametroRodamiento+margen,grosor+4], center=true);
                    }
                }
            }
            
            translate([separacionTornillos/2,separacionTornillos/2,0]) {
                cylinder(d=diametroTaladroMotor*2, h=grosor+4, center=true, $fn=definicion);
            }
        }
        translate([(largoMotor/2)-(largoMotor-separacionTornillos)/2, -(largoMotor/4)+(largoMotor/2),0]) {
            cube([(largoMotor-separacionTornillos),(largoMotor/2)+1,grosor+4], center=true);
        }
    }
    
    //  <--- v0.1
    */

}
//Hueco Brazo Tensor
//

//----------------------------------------------------

//
//Rodamiento
module rodamiento() {
    color("grey") {
        difference() {
            cylinder(d=diametroRodamiento, h=grosorRodamiento , center = true, $fn=definicion);
            cylinder(d=ejeRodamiento, h=grosorRodamiento+2, center=true, $fn=definicion);
        }
    }
}
//Rodamiento
//

//------------------------------------------------------

//
//base de anclaje
module carro_x() {
    hull() {
        translate([(anchoSoporte-redondeo)/2, 0, (altoSoporte-redondeo)/2]) {
            rotate([90,0,0]) {
                cylinder(r=redondeo, h=grosor, $fn=definicion, center=true);
            }
        }

        translate([(anchoSoporte-redondeo)/2, 0, -(altoSoporte-redondeo)/2]) {
            rotate([90,0,0]) {
                cylinder(r=redondeo, h=grosor, $fn=definicion, center=true);
            }
        }

        translate([-(anchoSoporte-redondeo)/2, 0, (altoSoporte-redondeo)/2]) {
            rotate([90,0,0]) {
                cylinder(r=redondeo, h=grosor, $fn=definicion, center=true);
            }
        }

        translate([-(anchoSoporte-redondeo)/2, 0, -(altoSoporte-redondeo)/2]) {
            rotate([90,0,0]) {
                cylinder(r=redondeo, h=grosor, $fn=definicion, center=true);
            }
        }
    }
}
//Base de Anclaje
//

//-------------------------------------------

//
//Drive Gear

module drive_gear() {
    color("grey") {
        difference() {
            union() {
                difference() {

                    cylinder(d=diametroDriveGear, h=altoDriveGear, center=true, $fn=definicion);

                    translate([0,0,(altoDriveGear/2)-1.7]) {
                        rotate_extrude() {
                            translate ([diametroDriveGear/2,0,0]) {
                                circle(d=diametroFilamento, $fn=definicion);
                            }
                        }
                    }
                }

                translate([0,0,-((altoDriveGear/2)-(5.25/2))]) {
                    cylinder(d=10, h=5.25, center=true, $fn=definicion);
                }
            }

            
            cylinder(d=diametroOrificioDG, h=altoDriveGear*2, center=true, $fn=definicion);
        }
    }
}


//Drive Gear
//

//-----------------------------------------

//
//filamento

module filamento() {
    translate([diametroDriveGear/2,0,0]) {
        rotate([90,0,0]) {
            color("orange"){
                cylinder(d=diametroFilamento, h=largoMotor*2, center=true, $fn=definicion);
            }
        }
    }
}

//filamento
//

//------------------------------------------

//
//taladros Motor

module taladros_motor() {
    translate([separacionTornillos/2,separacionTornillos/2,0]) {
        color("red") {
            cylinder(d=diametroTaladroMotor, h=grosor*2, center=true, $fn=definicion);
        }
    }
    translate([separacionTornillos/2,-separacionTornillos/2,0]) {
        color("red") {
            cylinder(d=diametroTaladroMotor, h=grosor*2, center=true, $fn=definicion);
        }
    }
    translate([-separacionTornillos/2,separacionTornillos/2,0]) {
        color("red") {
            cylinder(d=diametroTaladroMotor, h=grosor*2, center=true, $fn=definicion);
        }
    }
    translate([-separacionTornillos/2,-separacionTornillos/2,0]) {
        color("red") {
            cylinder(d=diametroTaladroMotor, h=grosor*2, center=true, $fn=definicion);
        }
    }
}


//taladros Motor
//

//------------------------------------------

//
//Nema 17
module nema_17() {
    union() {
        //Eje
        translate([-25,0,0]) {
            rotate([0,90,0]) {
                color("grey") {
                    cylinder(d=5, h=40, $fn=definicion, center=true);
                }
            }
        }
        //mazacote
        color("black") {
            cube([profundoMotor, largoMotor, largoMotor], center = true);
        }


        //Taladros para Nema17
        translate([-((profundoMotor/2)+(largoTornillo/2))+5,separacionTornillos/2,separacionTornillos/2]) {
            rotate([0,90,0]) {
                color("red") {
                    cylinder(d=3, h=largoTornillo, $fn=definicion, center=true);
                }
            }
        }

        translate([-((profundoMotor/2)+(largoTornillo/2))+5,separacionTornillos/2,-separacionTornillos/2]) {
            rotate([0,90,0]) {
                color("red") {
                    cylinder(d=3, h=largoTornillo, $fn=definicion, center=true);
                }
            }
        }

        translate([-((profundoMotor/2)+(largoTornillo/2))+5,-separacionTornillos/2,separacionTornillos/2]) {
            rotate([0,90,0]) {
                color("red") {
                    cylinder(d=3, h=largoTornillo, $fn=definicion, center=true);
                }
            }
        }

        translate([-((profundoMotor/2)+(largoTornillo/2))+5,-separacionTornillos/2,-separacionTornillos/2]) {
            rotate([0,90,0]) {
                color("red") {
                    cylinder(d=3, h=largoTornillo, $fn=definicion, center=true);
                }
            }
        }
    }
}

//Nema17
//

//-------------------------------------

//
//Cuerpo Extrusor

module cuerpo_extrusor() {
    
    union() {
        difference() {
            difference() {
                union() {
                
                    difference() {
                    
                        if (ptfe == "si") {
                            difference() {
                                
                                difference() {
                                    
                                    cube([largoMotor, largoMotor, grosor], center=true);
                                    
                                    taladros_motor();
                                }
                                
                                
                                translate([diametroDriveGear/2,0,0]) {
                                    rotate([90,0,0]) {
                                        if(diametroFilamento==1.75) {
                                            cylinder(d=4, h=largoMotor+2, center=true, $fn=definicion);
                                        }
                                        else if (diametroFilamento==3) {
                                            cylinder(d=6, h=largoMotor+2, center=true, $fn=definicion);
                                        }
                                    }
                                }
                            }
                            
                            translate([diametroDriveGear/2,0,0]) {
                                rotate([90,0,0]) {
                                    color("white") {    
                                        if(diametroFilamento==1.75) {
                                            difference() {
                                                cylinder(d=4, h=largoMotor+2, center=true, $fn=definicion);
                                                cylinder(d=2, h=largoMotor+4, center=true, $fn=definicion);
                                            }
                                        }
                                        else if (diametroFilamento==3) {
                                            difference() {
                                                cylinder(d=6, h=largoMotor+1, center=true, $fn=definicion);
                                                cylinder(d=4, h=largoMotor+2, center=true, $fn=definicion);
                                            }
                                        }
                                    }
                                }
                            }
                            
                            
                        }
                        else if (ptfe == "no") {
                            
                            difference() {
                            cube([largoMotor, largoMotor, grosor], center=true);
                                translate([diametroDriveGear/2,0,0]) {
                                    rotate([90,0,0]) {
                                        cylinder(d=diametroFilamento, h=largoMotor+2, center=true, $fn=definicion);
                                    }
                                }
                            }
                            
                        }
                        
                        
                        color("grey") {
                            cylinder(d=diametroDriveGear+margen, h=grosor*3, center=true, $fn=definicion);
                        }
                        
                    }
                    
                    
                    
                    
                    
                    
                    difference() {
                        
                        difference() {

                            difference() {
                                difference() {

                                    translate([diametroDriveGear/2, -(((longitudPreEndiduraHotend*2)+longitudEndiduraHotend)/2)-(largoMotor/2)+1,0]) {
                                        cube([largoMotor/1.5, (longitudPreEndiduraHotend*2)-1+longitudEndiduraHotend, grosor], center=true);
                                    }
                                    translate([diametroDriveGear/2, -(((longitudPreEndiduraHotend*2)+longitudEndiduraHotend)/2)-(largoMotor/2)+1,grosor/2]) {
                                        cube([(largoMotor/1.5)+1, (longitudPreEndiduraHotend*2)+longitudEndiduraHotend, grosor], center=true);
                                    }


                                }
                                translate([(diametroDriveGear/2)-(((largoMotor/1.5)/2)-diametroTaladroMotor*1.2), -(((longitudPreEndiduraHotend*2)+longitudEndiduraHotend)/2)-(largoMotor/2)+1,0]) {
                                    cylinder(d=diametroTaladroMotor, h = grosor+2, center=true, $fn=definicion);
                                }
                            }


                            translate([((diametroDriveGear/2)+(((largoMotor/1.5)/2)-diametroTaladroMotor*1.2)), -(((longitudPreEndiduraHotend*2)+longitudEndiduraHotend)/2)-(largoMotor/2)+1,0]) {
                                cylinder(d=diametroTaladroMotor, h = grosor+2, center=true, $fn=definicion);
                            }


                        }
                            
                            
                        difference() {
                            
                            translate([diametroDriveGear/2, -(((longitudPreEndiduraHotend*2)+longitudEndiduraHotend)/2)-(largoMotor/2)+1,0]) {
                                rotate([90,0,0]) { fusor(); }
                            }
                        
                        }
                        
                    }
                }
                
                translate([0,0,1-(grosor/2)]) {
                    cylinder(d=22, h=3, center=true, $fn=definicion);
                }
            }
        
            hueco_brazo_tensor();
            
        }
            
        tensor_muelle();
    
    }
    
}
//Cuerpo Extrusor
//

//-------------------------------------------------

//
//Tuerca Sujecion


module tuerca_sujecion(eje=3) {
    
    if(eje == 3) {
        translate([0,0,1.5]) {
            cylinder(d=6.01, h=4.5, center=true, $fn=6);
        }
    }
    else if(eje == 4) {
        translate([0,0,2]) {
            cylinder(d=7.66, h=5.5, center=true, $fn=6);
        }
    }
    else if(eje == 5) {
        translate([0,0,2]) {
            cylinder(d=8.79, h=5.5, center=true, $fn=6);
        }
    }
    
}


//Tuerca Sujecion
//

//--------------------------------------------------

//
//Fusor

module fusor() {
    difference() {
        cylinder(d=diametroHotend, h=(longitudPreEndiduraHotend*2)+longitudEndiduraHotend, center=true, $fn=definicion);
        difference() {
            cylinder(d=diametroHotend+2, h=longitudEndiduraHotend, center=true, $fn=definicion);
            cylinder(d=endiduraHotend, h=longitudEndiduraHotend+2, center=true, $fn=definicion);
        }
    }
}

//Fusor
//

//--------------------------------------------------

//
//Muelle Tensor

module muelle_tensor() {
    color("grey") {
        rotate([0,90,0]) {
            difference() {
                cylinder(d=odMuelle, h=largoMaxMuelle, center=true, $fn = definicion);
                cylinder(d=idMuelle, h=largoMaxMuelle+2, center=true, $fn = definicion);
            }
        }
    }
}

//Muelle Tensor
//

//
//Sujecion Hotend

module sujecion_hotend() {
    
    
    difference() {
        difference() {

            difference() {
                difference() {

                    translate([diametroDriveGear/2, -(((longitudPreEndiduraHotend*2)+longitudEndiduraHotend)/2)-(largoMotor/2)+1,0]) {
                        cube([largoMotor/1.5, (longitudPreEndiduraHotend*2)-1+longitudEndiduraHotend, grosor], center=true);
                    }
                    translate([diametroDriveGear/2, -(((longitudPreEndiduraHotend*2)+longitudEndiduraHotend)/2)-(largoMotor/2)+1,-grosor/2]) {
                        cube([(largoMotor/1.5)+1, (longitudPreEndiduraHotend*2)+longitudEndiduraHotend, grosor], center=true);
                    }


                }
                translate([(diametroDriveGear/2)-(((largoMotor/1.5)/2)-diametroTaladroMotor*1.2), -(((longitudPreEndiduraHotend*2)+longitudEndiduraHotend)/2)-(largoMotor/2)+1,0]) {
                    cylinder(d=diametroTaladroMotor, h = grosor+2, center=true, $fn=definicion);
                }
            }


            translate([((diametroDriveGear/2)+(((largoMotor/1.5)/2)-diametroTaladroMotor*1.2)), -(((longitudPreEndiduraHotend*2)+longitudEndiduraHotend)/2)-(largoMotor/2)+1,0]) {
                cylinder(d=diametroTaladroMotor, h = grosor+2, center=true, $fn=definicion);
            }


        }
        
        



        difference() {
                
            translate([diametroDriveGear/2, -(((longitudPreEndiduraHotend*2)+longitudEndiduraHotend)/2)-(largoMotor/2)+1,0]) {
                rotate([90,0,0]) { fusor(); }
            }
        
        }
    
    }


    
    
    
    
    
}

//Sujecion Hotend
//