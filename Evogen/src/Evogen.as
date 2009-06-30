package 
{
	import fighter.controller.breeder.FighterSpecimenEvaluator;
	import fighter.controller.callback.GameCallbackImpl;
	import fighter.controller.player.PlayerController;
	import fighter.controller.player.production.ComputerProductionTemplate;
	import fighter.controller.player.production.Production;
	import fighter.controller.runner.GameRunner;
	import fighter.controller.runner.GeneticAlgorithmRunner;
	import fighter.event.GeneticAlgorithmEvent;
	import fighter.model.breeder.BreederSettings;
	import fighter.model.game.DefaultLevel;
	import fighter.model.game.Game;
	import fighter.model.game.GameSettings;
	import fighter.model.player.Player;
	import fighter.model.tournament.TournamentSettings;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import org.evogen.breeder.TwoThirdsRatioBreeder;
	import org.evogen.entity.Specimen;
	import org.evogen.genetics.chromosome.Chromosome;
	import org.evogen.genetics.chromosome.ChromosomeTemplate;
	import org.evogen.genetics.trait.*;

	/**
	 * ...
	 * @author Paul Gibler
	 */
	[SWF(width="800", height="600", backgroundColor="0x000000", frameRate="30")]
	public class Evogen extends Sprite 
	{
		
		public function Evogen() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			testGA();
			//testGame();
		}
		
		private var ga : GeneticAlgorithmRunner;
		private var gameContainer : Sprite;
		private var gamePlayContainer : Sprite;
		private var gameInterfaceContainer : Sprite;
		
		private function testGA():void
		{
			var gameContainer : DisplayObjectContainer = new Sprite();
			stage.addChild(gameContainer);
			var gameSettings : GameSettings = new GameSettings(gameContainer, Game.SIMULATION);
			var tournamentSettings : TournamentSettings = new TournamentSettings();
			var breederSettings:BreederSettings = new BreederSettings(new TwoThirdsRatioBreeder(), new FighterSpecimenEvaluator(), 20, 100);
			ga = new GeneticAlgorithmRunner(breederSettings, tournamentSettings, gameSettings, stage);
			
			trace("Initial population:");
			ga.Players.forEach(function(player:Player, i:int, vec:Vector.<Player>):void
			{
				trace(i + " : " + player.BreedableSpecimen.SpecimenChromosome);
			});
			
			ga.addEventListener(GeneticAlgorithmEvent.COMPLETE, gaComplete);
			
			ga.Run();
		}
		
		private function gaComplete(event:Event):void
		{
			var specimens:Vector.<Specimen> = new Vector.<Specimen>();
			ga.Players.forEach(function(player:Player, i:int, vec:Vector.<Player>):void
			{
				specimens.push(player.BreedableSpecimen);
			});
			
			trace("Most fit specimens are:");
			specimens.forEach(function(spec:Specimen, i:int, vec:Vector.<Specimen>):void
			{
				trace(i + " : " + spec.SpecimenChromosome);
			});
			trace("Algorithm run time: "+(getTimer()/1000)+" seconds");
		}
		
		private function testGame():void
		{
			
			//KeyObject.initialize(stage);
			var gameSettings : GameSettings = new GameSettings(stage, Game.GRAPHICAL);
			var p1dna : String = "0107089302600740002909710699030105320468033306670384061601600840017800850185003300770146017801180194015901800060009700970093012102730026018700030190003901190162017601720128007101650108017200070021017201090165025700600099011601290184015501720084004501310102011501160116004302840003016301590171004900570181017800230186015404350565083601640188081202120788081701830463053703770623068803120087000402060039007303340014024201280193019601110182018600010002017401510142015400330163004901340143000403000251010200550037010802340054001600430363006400910136005500420052016701760108020901920019017100580036020301640149020002370227018800300033005201340099";
			var p2dna : String = "0905009504050595056704330310069003750625042305770854014605850415016100550067013801780133015901100093017002890042002902610082003400830036016500310224021900470195014300690199000001860084011002080188017600410052018601640071012301300100018301070120005101340175005500330223001001410156021201700145016500520209011900600181006803300670065703430428057204380562036706330676032404060594041005900260012802100030008400880189001101800054000201840039015301890200011402510038009401140232009900580097005702050106008800760264010702520039003403050021008000770192014201790169007601170013011901860191017801220001012701920141004800620208003801200074019201100196";
			var prodTemp : ComputerProductionTemplate = new ComputerProductionTemplate();
			var prod : Production = prodTemp.GenerateProductionFromDNA(p1dna);
			var pc : PlayerController = new PlayerController(prod);
			var p1 : Player = new Player(pc, new Specimen(prodTemp.LastGeneratedProductionChromosome));
			prod = prodTemp.GenerateProductionFromDNA(p2dna);
			pc = new PlayerController(prod);
			var p2 : Player = new Player(pc, new Specimen(prodTemp.LastGeneratedProductionChromosome));
			var game : Game = new Game(p1, p2, new DefaultLevel(), new GameCallbackImpl(), gameSettings);
			//var tourney : Tournament = new Tournament(new TournamentCallbackImpl(),
			var gr : GameRunner = new GameRunner(new GameCallbackImpl(), game);
			gr.Start();
		}
		
		private function testGenetics():void
		{
			var ct : ChromosomeTemplate = new ChromosomeTemplate();
			ct.AddTraitTemplate(new ProbabilisticTraitTemplate("crouching").AddState("attack").AddState("stand").AddState("jump"));
			ct.AddTraitTemplate(new ContinuousTraitTemplate("member length"));
			ct.AddTraitTemplate(new DiscreteTraitTemplate("hair color")	.AddState("a").AddState("b").AddState("c").AddState("d").AddState("e").AddState("f")
																		.AddState("g").AddState("h").AddState("i").AddState("j").AddState("k"));
			
			ct.AddTraitTemplate(new BinaryTraitTemplate("left-handed"));
			ct.AddTraitTemplate(new BinaryTraitTemplate("right-handed"));
			trace(ct.Traits);
			
			var c : Chromosome = ct.GenerateRandomChromosome();
			trace(c.ToDNA());
			trace(c.Mutate(.5).ToDNA());
		}
		
	}
	
}