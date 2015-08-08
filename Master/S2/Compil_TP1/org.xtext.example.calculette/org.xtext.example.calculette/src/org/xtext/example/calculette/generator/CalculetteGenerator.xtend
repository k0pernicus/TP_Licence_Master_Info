/*
 * generated by Xtext
 */
package org.xtext.example.calculette.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IGenerator
import org.eclipse.xtext.generator.IFileSystemAccess

import org.xtext.example.calculette.calculette.Calculette
import org.xtext.example.calculette.calculette.Rst
import org.xtext.example.calculette.calculette.Calc
import org.xtext.example.calculette.calculette.Expr
import org.xtext.example.calculette.calculette.Affec
import org.xtext.example.calculette.calculette.Cond
import org.xtext.example.calculette.calculette.Var
import org.xtext.example.calculette.calculette.Number
import org.eclipse.emf.ecore.EObject
import org.xtext.example.calculette.calculette.LastVar
import java.util.ArrayList
import java.util.List

/**
 * Generates code from your model files on save.
 * 
 * see http://www.eclipse.org/Xtext/documentation.html#TutorialCodeGeneration
 */
class CalculetteGenerator implements IGenerator {
	
	List<CharSequence> pile_calculs = new ArrayList<CharSequence>();
	boolean rst_bool = false;
	
	override void doGenerate(Resource resource, IFileSystemAccess fsa) {
		for(c: resource.allContents.toIterable.filter(Calculette))
		   fsa.generateFile(
		   	  "calculette/Calc.java",
		   	  c.compile
		   )
	}
	
	def CharSequence compile(EObject o) {
		
		/*
		 * Pile de calculs
		 */
		
		switch o {
			Calculette : '''
		package calculette;
		
		public class Calc {
			public static void main(String[] args)
				{
					int res = 0;
					«
					//Pour tous les calculs...
					FOR calcs:o.calculs
					»
					«
						//Calcul du nouvel élèment
						val calcul = calcs.compile
						»«calcul»
					«ENDFOR»
					System.out.println(res);
				}
		}
		'''
	        Calc : '''«o.e.compile»;'''
	        Rst : '''«changeRst_bool(false)»«
	        		  val rst=o.e.compile»«IF rst_bool == true»«
						//Si la longueur de la pile vaut 3, celà veut dire
						//qu'elle est pleine -> on enlève donc le premier
						//élèment de cette pile, afin de pouvoir y ajouter
						//le nouveau
						checkPile()»«
						pile_calculs.add(pile_calculs.length, rst)»«
	        		  ENDIF»«changeRst_bool(false)»res = «rst»
					 '''
            Number : '''«IF o.neg»-«ENDIF»«o.value»'''
	        Var : '''«o.name»_'''
	        LastVar : '''«
	        			IF o.varName=="$1"»«pile_calculs.get(0)»«ENDIF»«
	        			IF o.varName=="$2"»«pile_calculs.get(1)»«ENDIF»«
	        			IF o.varName=="$3"»«pile_calculs.get(2)»«ENDIF»
	        		  '''
	        Expr : '''«changeRst_bool(true)»(«o.left.compile») «o.op» («o.right.compile»)'''
	        Affec : '''int «o.name»_ = («o.right.compile»)'''
	        Cond : '''if («o.condition.compile») {
    «
					//Pour tous les calculs...
					FOR calcs:o.if_rst
					»«calcs.compile»«ENDFOR»
}
«IF o.else_rst != null»else {
    «FOR calcs:o.else_rst»«calcs.compile»«ENDFOR»
}«ENDIF»'''
		}
	}
	
	def void changeRst_bool(boolean bool) {
		rst_bool = bool;
	}
	
	def void checkPile() {
		if (pile_calculs.length >= 3)
			pile_calculs.remove(0);
	}
	
}