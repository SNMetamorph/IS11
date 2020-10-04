var step = 0;
var roomsList = [
    // дом
    [
        "Ты собрался прогуляться. Куда направишься?", // cообщение-вопрос
        ["впарк", "вкафе"], // варианты путей
        ["Ты направился в парк", "Ты направился в кафе"], // варианты сообщений-ответов
        [1, 2] // номера комнат, соответствующие вариантам путей
    ],
    // парк
    [
        "Ты пришел в парк. Куда теперь?", // cообщение-вопрос
        ["домой", "наплощадь"], // варианты путей
        ["Уже? Домой? Но почему так рано :(", "На площадь так на площадь!"], // варианты сообщений-ответов
        [0, 3] // номера комнат, соответствующие вариантам путей
    ],
    // кафе
    [
        "Ты пришел в кафе, но деньги с собой не взял. Куда теперь идти?", // cообщение-вопрос
        ["домой", "наплощадь", "впарк"], // варианты путей
        ["Домой? Далеко, но уж ладно.", "Идем на площадь", "Теперь идем в парк"], // варианты сообщений-ответов
        [0, 3, 1] // номера комнат, соответствующие вариантам путей
    ],
    // площадь
    [
        "Ты припёрся на площадь. Отсюда недалеко до парка. Куда направляешься дальше?",
        ["впарк", "вкафе"],
        ["Теперь идем в парк", "Теперь идем в кафе"],
        [1, 2]
    ]
];

function GetUserAnswer()
{
    return document.getElementById("playerAnswer").value
}

function SetQuestionText(text)
{
    document.getElementById("questionText").innerHTML = text;
}

function GoToLocation()
{
    var currentRoom = roomsList[step];
    if (!currentRoom) {
        return;
    }

    var questionText = currentRoom[0];
    var wayCases = currentRoom[1];
    var answerMessages = currentRoom[2];
    var roomNumbers = currentRoom[3];
    var answerText = GetUserAnswer().toLowerCase().replace(" ", "");

    for (var i = 0; i < wayCases.length; ++i)
    {
        if (answerText === wayCases[i])
        {
            step = roomNumbers[i];
            currentRoom = roomsList[step];
            questionText = currentRoom[0];
            SetQuestionText(questionText);
            break;
        }
    }
}

document.getElementById("goToLocation").addEventListener("click", GoToLocation);

// дз. добавить кнопки стрельбы во все мишени
// *переписать игру на функции и сделать UX-интерфейс в котором пользователль будет в input писать куда он хочет пойти
// **в репозитории создать новую ветку rpg и в нее залить код игры
