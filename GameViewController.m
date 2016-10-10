//
//  GameViewController.m
//  CityGame
//
//  Created by Baris.
//  Copyright (c) 2016 Baris. All rights reserved.
//

#import "GameViewController.h"
#define getURL @"https://app.lcwaikiki.com/v1/cities.json"


@interface GameViewController()

@property (weak, nonatomic) IBOutlet UITextView *questionText;
@property(nonatomic)NSInteger began;
@property(strong, nonatomic)NSMutableArray *cityArray;
@property(nonatomic)NSMutableString *trueResult;
@property(strong, nonatomic)NSMutableArray *jsonArray;
@property(nonatomic)NSInteger score;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *selections;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end



@implementation GameViewController

- (IBAction)newGameTime:(UIButton *)sender {
    [self getANewQuestion];
    _score =0;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %li", (long)_score];
    _began = 1;
}


- (IBAction)arrangeQuestion:(UIButton *)sender {
    if(_began==1)
        [self getANewQuestion];
}


-(void)viewDidLoad{
    [super viewDidLoad];
    _began=0;
    [self getDataFromWeb];
}

-(void)getANewQuestion{
    NSInteger arrayIndex = arc4random()%81;
    City *selectedCity = [self.cityArray objectAtIndex:arrayIndex];
    self.questionText.text = [NSString stringWithFormat:@"Kanki, could you tell me which is the city ID of %@ ?", selectedCity.cityName];
    _trueResult = selectedCity.cityID;
    NSInteger trueResultedButton = arc4random()%5;
    UIButton *trueSelection = self.selections[trueResultedButton];
    [trueSelection setTitle:[NSString stringWithFormat:@"%@", selectedCity.cityID] forState:UIControlStateNormal];
    for(UIButton *anotherButton in self.selections){
        if(!(anotherButton == trueSelection)){
            NSInteger anAnswer = arc4random()%82;
            if(anAnswer ==0)
                anAnswer++;
            NSString *answerString = [NSString stringWithFormat:@"%li", (long)anAnswer];
            [anotherButton setTitle:[NSString stringWithFormat:@"%@", answerString] forState:UIControlStateNormal];
        }
    }
}

- (IBAction)choiceMade:(UIButton *)sender {
    if(_began==1){
    NSInteger chosedIndex = [self.selections indexOfObject:sender];
    UIButton *anyButton = [self.selections objectAtIndex:chosedIndex];
    NSMutableString *chosedAnswer = [[NSMutableString alloc]initWithFormat:@"%@",anyButton.currentTitle];
    if([chosedAnswer isEqualToString:[NSString stringWithFormat:@"%@", _trueResult]]){
        self.score++;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %li", (long)_score];
        self.questionText.text = [NSString stringWithFormat:@"True, Kanki very good answer"];
    }
    else{
        self.score--;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %li", (long)_score];
        self.questionText.text = [NSString stringWithFormat:@"Unfortunately kanki, wrong answer. The true answer was %@", _trueResult];
    }
    }
    
}

-(NSMutableArray *)jsonArray{
    if(!_jsonArray) _jsonArray = [[NSMutableArray alloc]init];
    return _jsonArray;
}

-(NSMutableArray *)cityArray{
    if(!_cityArray) _cityArray = [[NSMutableArray alloc]init];
    return _cityArray;
}


-(void)getDataFromWeb{
    NSURL *url = [NSURL URLWithString:getURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDictionary *retrieved = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    _jsonArray = retrieved[@"cities"];
    if(!_cityArray) _cityArray = [[NSMutableArray alloc]init];
    for(int i =0; i<_jsonArray.count; i++){
        NSString *cName = [[_jsonArray objectAtIndex:i]objectForKey:@"name"];
        NSString *cID = [[_jsonArray objectAtIndex:i]objectForKey:@"cityId"];
        [_cityArray addObject:[[City alloc]initWithCityName:cName andCityID:cID]];
    }
}

@end
