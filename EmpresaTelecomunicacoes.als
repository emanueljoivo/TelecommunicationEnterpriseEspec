module EmpresaTelecomunicacoes

----------------------------------------------------------
--			ASSINATURAS			--
----------------------------------------------------------

abstract sig Plano {
	servicos : set Servico
}

sig Simples extends Plano {}
sig Double extends Plano {}
sig Combo extends Plano {}

abstract sig Servico {}

one sig Internet extends Servico {
	planosDeInternet : set PlanoDeInternet	
}
one sig Telefone extends Servico {
	planosDeTelefone : set PlanoDeTelefone
}
one sig TV extends Servico {
	planosDeTV : set PlanoDeTV
}

abstract sig PlanoDeInternet {}
abstract sig PlanoDeTelefone {}
abstract sig PlanoDeTV {}

one sig CincoMB extends PlanoDeInternet {}
one sig TrintaECincoMB extends PlanoDeInternet {}
one sig SessentaMB extends PlanoDeInternet {}
one sig CentoEVinteMB extends PlanoDeInternet {}

one sig IlimitadoLocal extends PlanoDeTelefone {}
one sig IlimitadoBrasil extends PlanoDeTelefone {}
one sig IlimitadoMundo extends PlanoDeTelefone {}

one sig Noticias extends PlanoDeTV {}
one sig Infantis extends PlanoDeTV {}
one sig Filmes extends PlanoDeTV {}
one sig Documentarios extends PlanoDeTV {}
one sig Series extends PlanoDeTV {}
one sig ProgramaDeTV extends PlanoDeTV {}

------------------------------------------------------------------
--				FATOS				--
------------------------------------------------------------------

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
}

fact ApenasUmPlanoDeTelefone {
	all t : Telefone | one (t.planosDeTelefone)
}

fact AlgunsPlanosDeTV {
	all t : TV | some (t.planosDeTV)
}


pred show[] {}

run show for 3
