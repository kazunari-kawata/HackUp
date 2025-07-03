<?php
// CORS対策
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header('Content-Type: application/json');

// DB接続情報
require_once('db.php');

// POSTデータ取得
$title = $_POST['title'] ?? '';
$description = $_POST['description'] ?? '';
$user_id = $_POST['user_id'] ?? null;

// 入力バリデーション（簡易）
if (!$title || !$description || !$user_id) {
    echo json_encode(["error" => "Missing required fields"]);
    exit();
}

// SQL作成
$sql = 'INSERT INTO hacks (user_id, title, description, created_at, upvotes, downvotes) 
        VALUES (:user_id, :title, :description, NOW(), 0, 0)';

$stmt = $pdo->prepare($sql);
$stmt->bindValue(':user_id', $user_id, PDO::PARAM_INT);
$stmt->bindValue(':title', $title, PDO::PARAM_STR);
$stmt->bindValue(':description', $description, PDO::PARAM_STR);

// SQL実行
try {
    $status = $stmt->execute();
    echo json_encode(["success" => true]);
} catch (PDOException $e) {
    echo json_encode(["sql error" => "{$e->getMessage()}"]);
    exit();
}
