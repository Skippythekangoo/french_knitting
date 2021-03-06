/* [Valeurs paramétrables] */
// Nombre d'intervale
nb_intervale=10;
// Largeur du tricotin
larg_ext_min=30;
// Style d'impression 
mobile="picot";//["cadre","picot","picot_seul","cadre_rond"]
// Style de têtes
tete="sphere";//["ronde","sphere","plate"]
// Résolution des sphères et cylindres
R=50; 

/* [Hidden] */
// Longueur des extrémités
long_ext_min=10;
// Epaisseur du cadre
epaisseur=5;
// Largeur des intervales
larg_intervale=10;
long_int_min=long_ext_min-10;
larg_int_min=larg_ext_min-10;


// Extrémités en U
module bout_cadre(){
	difference(){
		cube([larg_ext_min,long_ext_min,epaisseur], center=false);
		translate([5,5,-1]) cube([larg_int_min,long_int_min+6,epaisseur+2], center=false);
		translate([larg_ext_min/2,2.5,2]) cylinder(4,r=2,$fn=R);
	}
}


module bout_picot(){
	difference(){
		cube([larg_ext_min,long_ext_min,epaisseur], center=false);
		translate([5,5,-1]) cube([larg_int_min,long_int_min+6,epaisseur+2], center=false);
        }
        if(tete=="ronde"){
            translate([larg_ext_min/2,2.5,2]) cylinder(14,r=2,$fn=R);
            translate([larg_ext_min/2,2.5,16]) sphere(r=2,$fn=R);
        }
        else if(tete=="sphere"){
            translate([larg_ext_min/2,2.5,2]) cylinder(14,r=2,$fn=R);
            translate([larg_ext_min/2,2.5,16]) sphere(r=4,$fn=R);
        }
        else if(tete=="plate"){
            translate([larg_ext_min/2,2.5,2]) cylinder(16,r=2,$fn=R);
            //translate([larg_ext_min/2,2.5,16]) sphere(r=4,$fn=R);  
        }        
}


// Intervales avec trous
module intervale_trou(){
	difference(){
		cube([larg_ext_min,larg_intervale,epaisseur]);
		translate([long_ext_min/2,-1,-1]) cube([larg_int_min,12,epaisseur+2]);
		translate([2.5,5,2]) cylinder(4,r=2,$fn=R);
		mirror([1,0,0]) translate([-larg_ext_min+2.5,5,2]) cylinder(4,r=2,$fn=R);
	}
}

// Intervale avec picots
module intervale_picot(){
    union(){
        difference(){
            cube([larg_ext_min,larg_intervale,epaisseur]);
            translate([long_ext_min/2,-1,-1]) cube([larg_int_min,12,epaisseur+2]);
        }
        if(tete=="ronde"){
            translate([2.5,5,2]) cylinder(14,r=2,$fn=R);
            translate([2.5,5,16]) sphere(r=2,$fn=R);
            mirror([1,0,0]) translate([-larg_ext_min+2.5,5,2]) cylinder(14,r=2,$fn=R);
            mirror([1,0,0]) translate([-larg_ext_min+2.5,5,16]) sphere(r=2,$fn=R);
        }
        else if(tete=="sphere"){
            translate([2.5,5,2]) cylinder(14,r=2,$fn=R);
            translate([2.5,5,16]) sphere(r=4,$fn=R);
            mirror([1,0,0]) translate([-larg_ext_min+2.5,5,2]) cylinder(14,r=2,$fn=R);
            mirror([1,0,0]) translate([-larg_ext_min+2.5,5,16]) sphere(r=4,$fn=R);
        }
        else if(tete=="plate"){
            translate([2.5,5,2]) cylinder(16,r=2,$fn=R);
            //translate([2.5,5,16]) sphere(r=4,$fn=R);
            mirror([1,0,0]) translate([-larg_ext_min+2.5,5,2]) cylinder(16,r=2,$fn=R);
            //mirror([1,0,0]) translate([-larg_ext_min+2.5,5,16]) sphere(r=4,$fn=R);
        }
    }
}

// Picots
module picot(){
    rotate([0,90,0]) cylinder(14,r=2,$fn=R);
    if(tete=="ronde"){
        rotate([0,90,0]) translate([0,0,14]) sphere(r=2,$fn=R);
    }
    else if(tete=="sphere"){
        rotate([0,90,0]) translate([0,0,14]) sphere(r=4,$fn=R);
        }
}

if(mobile=="cadre"){
    for (i=[1:1:nb_intervale]){
        translate([0,long_ext_min*i,0]) intervale_trou();
    }
    bout_cadre();
    mirror([0,1,0]) translate([0,-long_ext_min-larg_intervale*(nb_intervale+1),0]) bout_cadre();
    for (i=[1:1:nb_intervale+1]){
//        translate([larg_ext_min+10,long_ext_min*i,0]) picot();
 //       translate([-larg_ext_min,long_ext_min*i,0]) picot();

    }
}

if(mobile=="picot"){
    for (i=[1:1:nb_intervale]){
        translate([0,long_ext_min*i,0]) intervale_picot();
    }
    bout_cadre_rond_picot();
    mirror([0,1,0]) translate([0,-long_ext_min-larg_intervale*(nb_intervale+1),0]) bout_cadre_rond_picot();
}

if(mobile=="picots_seuls"){
    for (i=[1:1:nb_intervale]){
        translate([0,long_ext_min*i,0]) picot();
        mirror([1,0,0]) translate([10,long_ext_min*i,0]) picot();
    }
}

if(mobile=="picot_seul"){
    picot();
}

///////////////////////////////////
// test pour arrondir les angles //
///////////////////////////////////

module bout_cadre_rond(){
	difference(){
		minkowski(){
			translate([1,0,0]) cube([larg_ext_min-2,long_ext_min,epaisseur-0.5], center=false);
			cylinder(r=1, h=0.5, $fn=R);
		}
		translate([5,5,-1]) cube([larg_int_min,long_int_min+6,epaisseur+2], center=false);
		translate([larg_ext_min/2,2.5,2]) cylinder(4,r=2,$fn=R);
	}
}

if(mobile=="cadre_rond"){
    for (i=[1:1:nb_intervale]){
        translate([0,long_ext_min*i,0]) intervale_trou();
    }
    bout_cadre_rond();
    mirror([0,1,0]) translate([0,-long_ext_min-larg_intervale*(nb_intervale+1),0]) bout_cadre_rond();
    for (i=[1:1:nb_intervale+1]){

    }
}

//bout_cadre_rond();
//	difference(){
//		minkowski(){
//		cube([larg_ext_min,long_ext_min,epaisseur], center=false);
//		#cylinder(r=1, h=0.5, $fn=R);
//		}
//		translate([5,5,-1]) cube([larg_int_min,long_int_min+6,epaisseur+2], center=false);
//		}


module bout_cadre_rond_picot(){
	difference(){
		minkowski(){
			translate([1,0,0]) cube([larg_ext_min-2,long_ext_min,epaisseur-0.5], center=false);
			cylinder(r=1, h=0.5, $fn=R);
		}
		translate([5,5,-1]) cube([larg_int_min,long_int_min+6,epaisseur+2], center=false);
        }
        if(tete=="ronde"){
            translate([larg_ext_min/2,2.5,2]) cylinder(14,r=2,$fn=R);
            translate([larg_ext_min/2,2.5,16]) sphere(r=2,$fn=R);
        }
        else if(tete=="sphere"){
            translate([larg_ext_min/2,2.5,2]) cylinder(14,r=2,$fn=R);
            translate([larg_ext_min/2,2.5,16]) sphere(r=4,$fn=R);
        }
        else if(tete=="plate"){
            translate([larg_ext_min/2,2.5,2]) cylinder(16,r=2,$fn=R);
            //translate([larg_ext_min/2,2.5,16]) sphere(r=4,$fn=R);  
        }        
}
