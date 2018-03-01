module Main

sig Operator {
	internet: Service,
	telephone: Service,
	tv: Service	
}

sig Service {
	plan: set Plan
}

abstract sig Plan {}

sig PlanSimple extends Plan {}

sig PlanDouble extends Plan {}

sig PlanCombo extends Plan {}

pred show[] {}

run show for 1
