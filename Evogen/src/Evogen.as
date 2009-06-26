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
		
		private function testGA():void
		{
			
			var gameSettings : GameSettings = new GameSettings(stage, Game.SIMULATION);
			var tournamentSettings : TournamentSettings = new TournamentSettings();
			var breederSettings:BreederSettings = new BreederSettings(new TwoThirdsRatioBreeder(), new FighterSpecimenEvaluator(), 50, 100);
			ga = new GeneticAlgorithmRunner(breederSettings, tournamentSettings, gameSettings);
			
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
			var p1dna : String = "0550045004780522098500150294070604030597037306270746025405380462002801410020011301120189019302050011023401150183006100790229008802390043005300450081022701830130000700420186010103350109004201770023019702780008007700510087027901460162012001070128015500620118018200440059007001960174014001360141017501790018009702050095009001900810067903210280072006250375030306970349065102300770042805720265019402160065013800050010010801410079012001420082011201050218014701640144010801830098002901270005024101080008014401980144015300470006019001650075006902990149005000720205010401550031010802740125018301690116008401000050017300820118018200410119009301480217";
			var p2dna : String = "0765023502000800037106290310069001970803089801020236076405560444021900240045021100650194000902330121007201160162010000960078025601470163014700230091018901450095009900730069000702330184012302130158008002780006006500190177021702840149012400990047003501670095012001820112019300360022011502200164000100730148021301630157008104570543095900410681031908140186060703930648035206520348047005300008017501400104013901020170016200720067016802120190016600440081015400410183014600270065019401900021019000720264016501580108002303160086003100230048022300630209028600090160011400140018020101980191011601760114007400460019026400440131019900370087000801490345";
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