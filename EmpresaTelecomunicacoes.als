module EmpresaTelecomunicacoes

----------------------------------------------------------
--			ASSINATURAS			--
----------------------------------------------------------

abstract one sig Plano {
	servicos : set Servico
}

sig Simples extends Plano {}
sig Double extends Plano {}
sig Combo extends Plano {}

abstract sig Servico {}

sig Internet extends Servico {
	planosDeInternet : set PlanoDeInternet	
}
sig Telefone extends Servico {
	planosDeTelefone : set PlanoDeTelefone
}
sig TV extends Servico {
	planosDeTV : set PlanoDeTV
}

abstract sig PlanoDeInternet {}
abstract sig PlanoDeTelefone {}
abstract sig PlanoDeTV {}

sig CincoMB extends PlanoDeInternet {}
sig TrintaECincoMB extends PlanoDeInternet {}
sig SessentaMB extends PlanoDeInternet {}
sig CentoEVinteMB extends PlanoDeInternet {}

sig IlimitadoLocal extends PlanoDeTelefone {}
sig IlimitadoBrasil extends PlanoDeTelefone {}
sig IlimitadoMundo extends PlanoDeTelefone {}

sig Noticias extends PlanoDeTV {}
sig Infantis extends PlanoDeTV {}
sig Filmes extends PlanoDeTV {}
sig Documentarios extends PlanoDeTV {}
sig Series extends PlanoDeTV {}
sig ProgramaDeTV extends PlanoDeTV {}

------------------------------------------------------------------
--				FATOS				--
------------------------------------------------------------------

fact ServicoFazParteDePlano {
	all i : PlanoDeInternet | some i.~planosDeInternet 
	all t : PlanoDeTelefone | some t.~planosDeTelefone 
	all v : PlanoDeTV | some v.~planosDeTV

	all s: Servico| one s.~servicos
}

fact PlanoSimpleTemUmServico {
	all s : Simples | one (s.servicos)
}

fact PlanoDoubleTemDoisServicos {
	all d : Double | #(d.servicos) = 2
}

fact PlanoComboTemTodosServicos {
 	all c : Combo | #(c.servicos) = 3
}

fact ApenasUmPlanoDeInternet {
	all i : Internet | one (i.planosDeInternet)
	#Internet < 2
}

fact ApenasUmPlanoDeTelefone {
	all t : Telefone | one (t.planosDeTelefone)
	#Telefone < 2
}

fact AlgunsPlanosDeTV {
	all t : TV | some (t.planosDeTV)
	#TV < 2
	#Noticias < 2
	#Infantis < 2
	#Filmes < 2
	#Documentarios < 2
	#Series < 2
	#ProgramaDeTV < 2

}

pred show[] {}

run show for 3
