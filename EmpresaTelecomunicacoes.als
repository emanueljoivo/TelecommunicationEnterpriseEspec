module EmpresaTelecomunicacoes

----------------------------------------------------------
--			ASSINATURAS			--
----------------------------------------------------------
abstract sig Cliente {
	planos : set Plano
}

abstract sig Plano {
	servicosDeTV : set TV,
	servicosDeTelefone : set Telefone,
	servicosDeInternet : set Internet
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

fact ClienteTemApenasUmPlano {
	all c : Cliente | UmPlano[c]
}

fact PlanoFazParteDeCliente {
	all p : Plano | some p.~planos
}

fact ServicoFazParteDePlano {
	all i : PlanoDeInternet | some i.~planosDeInternet 
	all t : PlanoDeTelefone | some t.~planosDeTelefone 
	all v : PlanoDeTV | some v.~planosDeTV

	all tv: TV | some  tv.~servicosDeTV
	all tf: Telefone | some tf.~servicosDeTelefone
	all nt: Internet | some nt.~servicosDeInternet
}

fact PlanoSimpleTemUmServico {
	all s : Simples | PlanoSimples[s]
}

fact PlanoDoubleTemDoisServicos {
	all d : Double | PlanoDouble[d]
}

fact PlanoComboTemTodosServicos {
 	all c : Combo | PlanoCombo[c]
}

fact TodoPlanoTemNoMaximoUmTipoDeServico{
	all p: Plano | MaximoUmServico[p] 
}

fact TemApenasUmPlanoDeInternetPorVez {
	all i : Internet | UmPlanoDeInternet[i]
	#CincoMB < 2
	#TrintaECincoMB < 2
	#SessentaMB < 2
	#CentoEVinteMB < 2
}

fact TemApenasUmPlanoDeTelefonePorVez {
	all t : Telefone | UmPlanoDeTelefone[t]
	#IlimitadoLocal < 2
	#IlimitadoBrasil < 2
	#IlimitadoMundo < 2
}

fact TemAlgunsPlanosDeTVPorVez {
	all tv : TV | AlgunsPlanoDeTV[tv]
	#Noticias < 2
	#Infantis < 2
	#Filmes < 2
	#Documentarios < 2
	#Series < 2
	#ProgramaDeTV < 2
}

----------------------------------------------------------
--			PREDICADOS			--
----------------------------------------------------------
pred UmPlano [c: Cliente] {
	#(c.planos) = 1
}

pred MaximoUmServico [p: Plano] {
	#(p.servicosDeTV) < 2
	#(p.servicosDeTelefone) < 2
	#(p.servicosDeInternet) < 2	
}

pred PlanoSimples [s: Simples] {
	#getServicosSimples[s] = 1
}

pred PlanoDouble [d: Double] {
	#getServicosDouble[d] = 2
}

pred PlanoCombo [c: Combo] {
	#getServicosCombo[c] = 3
}

pred UmPlanoDeInternet [i:Internet] {
	#(i.planosDeInternet) = 1
}

pred UmPlanoDeTelefone [t:Telefone] {
	#(t.planosDeTelefone) = 1
}

pred AlgunsPlanoDeTV [tv: TV] {
	#(tv.planosDeTV) > 1
}

------------------------------------------------------------------
--				FUNCOES				--
------------------------------------------------------------------

fun getServicosSimples[s:Simples]: set Servico{
	s.servicosDeTV + s.servicosDeTelefone + s.servicosDeInternet
}

fun getServicosDouble[d:Double]: set Servico{
	d.servicosDeTV + d.servicosDeTelefone + d.servicosDeInternet
}

fun getServicosCombo[c:Combo]: set Servico{
	c.servicosDeTV + c.servicosDeTelefone + c.servicosDeInternet
}


pred show[] {}

run show for 10
